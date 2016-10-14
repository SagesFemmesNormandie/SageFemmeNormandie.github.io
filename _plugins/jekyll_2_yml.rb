# encoding: utf-8
#
# Title:
# ======
# Jekyll to YML Generator
#
# Description:
# ============
# A plugin for generating a JSON to an YML from a liquid tpl
#
# Author:
# ======
# Bertrand Keller
# Bertrand.keller@gmail.com

#:post_render

module Jekyll

  class JSONGenerator < Generator
    safe true
    priority :low

    def generate(site)

      # Converter for .md > .html
      converter = site.find_converter_instance(Jekyll::Converters::Markdown)

      regEx = /^[\s]*$\n/

      # Encode the HTML to YML
      tmpl = File.read File.join Dir.pwd, "_data/members.liquid"
      tmpl = (Liquid::Template.parse tmpl).render site.site_payload
      tmpl = tmpl.gsub! '---', ''
      #tmpl = tmpl.gsub! '  -', '-'
      tmpl = tmpl.gsub! /^$\n/, ''
      tmpl = tmpl.gsub(regEx, '').strip

      # Start building the path
      path = "_data/"

      # Create the directories from the path
      FileUtils.mkpath(path) unless File.exists?(path)

      # Create the YML file and inject the data
      f = File.new("#{path}/members.yml", "w+")
      f.puts File.join(tmpl)


    end

  end

end
