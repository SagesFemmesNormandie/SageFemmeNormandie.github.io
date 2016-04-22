task :build => ["build:prod"]
namespace :build do

  desc "Regenerate files for production"
  task :prod do
    puts "* Regenerating files for production..."
    system "jekyll build"
    system "JEKYLL_ENV=production bundle exec jekyll build"
  end

  desc "Regenerate files for production (Windows systems)"
  task :win do
    puts "* Regenerating files for production..."
    system "bundle exec jekyll build"
  end

  desc "Regenerate files for development"
  task :dev do
    puts "* Regenerating files for development..."
    system "bundle exec jekyll build --config _config.yml,_config.dev.yml --profile"
  end

  desc "Regenerate files and drafts for development"
  task :drafts do
    puts "* Regenerating files and drafts for development..."
    system "bundle exec jekyll build --config _config.yml,_config.dev.yml --profile --drafts"
  end
end
