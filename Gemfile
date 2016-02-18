source 'https://rubygems.org'

require 'json'
require 'open-uri'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

open('https://www.google.com/')

versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']

group :development do
    gem 'foreman'
end

group :test do
    gem 'rake'
    gem 'jekyll', versions['jekyll']
    gem 'html-proofer'
end

group :jekyll_plugins do
  gem 'jekyll-gdrive'
end
