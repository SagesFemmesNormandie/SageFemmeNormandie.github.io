source 'https://rubygems.org'

require 'json'
require 'open-uri'
# require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#export GDRIVE=84726834603-hqfllakca9mfehbi6bndt54qhtr4bglb.apps.googleusercontent.com:sFvTqAC_L7GfiiGtvkmoX7UP:1/MyRS8MPgQgE1RZKrwTZjIzC6vAxavu9wLnbyNj_d_pU

versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']
#gem 'mini_magick'
#gem 'autoprefixer-rails'
#gem 'uglifier'

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
  #gem 'jekyll-assets', github: 'jekyll/jekyll-assets'
  #gem 'jekyll-sitemap', github: 'jekyll/jekyll-sitemap'
end
