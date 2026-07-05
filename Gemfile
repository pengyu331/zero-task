source "https://rubygems.org"

ruby file: ".ruby-version"

gem "vite_rails", "~> 3.0"
gem "rails", "~> 8.1.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "dotenv", ">= 3.0"
  gem "rspec-rails"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "erb_lint", require: false
  gem "web-console"
end

group :test do
  gem "selenium-webdriver", require: false
  gem "capybara", require: false
end
