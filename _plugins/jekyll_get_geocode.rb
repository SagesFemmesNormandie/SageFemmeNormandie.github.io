require 'json'
require 'yaml'
require 'open-uri'
require 'i18n'
require 'geocoder'
require 'logger'

module JekyllGeocode
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def initialize(site = nil)
      super
      Geocoder.configure(lookup: :nominatim, timeout: 60,
                         http_headers: { 'User-Agent' => 'jekyll-geocode-plugin' })
      I18n.config.available_locales = :en
    end

    def request_service(address)
      return nil if address.to_s.strip == ''
      Geocoder.coordinates(address)
    rescue StandardError => _e
      nil
    end

    def generate(site)
      cfg = site.config.fetch('jekyll_geocode', nil)
      return unless cfg
      cfg = cfg.is_a?(Array) ? cfg.first : cfg

      dev_limit = cfg['dev_limit'] # nil => full run; 0 => no requests but generate dummy; >0 => limit
      limited = !dev_limit.nil?
      remaining = dev_limit.to_i if limited

      filename     = cfg['file-name'] || 'members.yml'
      filepath     = cfg['file-path']
      outputfile   = cfg['outputfile']
      geo_name     = cfg['name']    || 'name'
      geo_address  = cfg['address'] || 'address'
      geo_postcode = cfg['postcode']
      geo_city     = cfg['city']
      geo_region   = cfg['region']
      geo_country  = cfg['country']
      cache_json   = cfg['cache']

      data_source = filepath || site.config['data_source'] || '.'
      members_path = File.join(data_source, filename)
      return unless File.file?(members_path)

      members = YAML.load_file(members_path)
      return if members.nil? || members.size <= 1

      # Start processing entries (skip header row if present)
      members.drop(1).each do |entry|
        # stop if limited and no remaining requests allowed
        break if limited && remaining && remaining <= 0

        name_value = entry[geo_name]
        next unless name_value && entry[geo_address]

        # Build slug (you can change this to use a dedicated slug field if needed)
        slug = name_value.to_s.downcase.tr(' ', '-').gsub(/[^\w\-]/, '')
        addr_parts = []
        addr_parts << entry[geo_address].to_s
        addr_parts << entry[geo_postcode].to_s if geo_postcode && entry[geo_postcode]
        addr_parts << entry[geo_city].to_s     if geo_city && entry[geo_city]
        addr_parts << entry[geo_region].to_s   if geo_region && entry[geo_region]
        addr_parts << entry[geo_country].to_s  if geo_country && entry[geo_country]

        full_address = addr_parts.reject(&:empty?).join(', ')
        simple_address = [entry[geo_city], entry[geo_region], entry[geo_country]].compact.join(', ')

        # If dev mode with 0, skip external requests but still populate dummy data for local tests
        if limited && dev_limit.to_i == 0
          site.data[slug] = build_record(name_value, full_address, [0.0, 0.0])
          Jekyll.logger.info "JekyllGeocode:", "DEV mode (0) - created dummy coords for #{name_value} (#{slug})"
          next
        end

        # If we already have valid cached data (e.g., JSON cached earlier), skip request
        if site.data.key?(slug)
          cached = site.data[slug]
          if cached.is_a?(Hash) && cached['location'] && cached['location']['latitude'] && cached['location']['longitude']
            Jekyll.logger.info "JekyllGeocode:", "using existing site.data coords for #{name_value} (#{slug})"
            next
          end
        end

        Jekyll.logger.info "JekyllGeocode:", "geocode is requesting #{name_value}: #{full_address}"
        coords = request_service(full_address)

        unless coords
          Jekyll.logger.warn "JekyllGeocode:", "primary geocode failed for #{name_value}, trying simplified address: #{simple_address}"
          coords = request_service(simple_address)
        end

        if coords && coords[0] && coords[1]
          site.data[slug] = build_record(name_value, full_address, coords)
          remaining -= 1 if limited && remaining
          Jekyll.logger.info "JekyllGeocode:", "got coords for #{name_value} -> #{coords[0]}, #{coords[1]} (#{slug})"

          # Optionally write per-entry JSON cache if cache flag enabled
          if cache_json
            begin
              data_source_dir = data_source || '.'
              Dir.mkdir(data_source_dir) unless Dir.exist?(data_source_dir)
              path_json = File.join(data_source_dir, "#{slug}.json")
              File.open(path_json, 'wb') { |f| f << JSON.generate(site.data[slug]) }
              Jekyll.logger.info "JekyllGeocode:", "wrote cache JSON for #{slug} at #{path_json}"
            rescue StandardError => e
              Jekyll.logger.warn "JekyllGeocode:", "failed to write cache JSON for #{slug}: #{e.message}"
            end
          end
        else
          Jekyll.logger.warn "JekyllGeocode:", "no coordinates found for #{name_value}; skipping site.data assignment to avoid empty entries"
        end
      end
    end

    private

    def build_record(title, address, coords)
      {
        'title' => title.to_s,
        'url' => "##{title}",
        'data_set' => '01',
        'location' => { 'latitude' => coords[0].to_s, 'longitude' => coords[1].to_s },
        'address' => address.to_s
      }
    end
  end
end
