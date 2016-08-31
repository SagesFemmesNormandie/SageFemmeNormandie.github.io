require 'json'
require 'hash-joiner'
require 'open-uri'

module Jekyll_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      members = YAML.load_file('_data/members.yml')
      members.each do |d|
        address = d['adresse-geo']
        ville = d['ville']
        json = URI.encode("https://nominatim.openstreetmap.org/?format=json&q=#{address},#{ville},fr&limit=1")
        target = site.data[d['nom_entier']]
        source = JSON.load(open(json))
        site.data[d['nom_entier']] = source
        # data_source = ('_data')
        # path = "#{data_source}/#{d['nom_entier']}.json"
        # open(path, 'wb') do |file|
        #   file << JSON.generate(site.data[d['nom_entier']])
        # end
      end
    end
  end
end
