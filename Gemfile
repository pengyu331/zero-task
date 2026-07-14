# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

gem "bootsnap", require: false
gem "devise"
gem "image_processing", "~> 1.2"
gem "jbuilder"
gem "kamal", require: false
gem "kaminari"
gem "omniauth-github"
gem "omniauth-rails_csrf_protection"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.1.3"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "stimulus-rails"
gem "thruster", require: false
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "vite_rails", "~> 3.0"

group :development, :test do
  gem "amazing_print"
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "dotenv", ">= 3.0"
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "simplecov", require: false
end

group :development do
  gem "erb_lint", require: false
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "web-console"
end

group :test do
  gem "capybara", require: false
  gem "selenium-webdriver", require: false
  gem "shoulda-matchers"
end
