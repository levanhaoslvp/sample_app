# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.0.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "active_storage_validations"
gem "acts_as_votable"
gem "bcrypt"
gem "bootstrap-sass"
gem "bootstrap-will_paginate"
gem "faker"
gem "image_processing"
gem "mini_magick"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.3", ">= 6.1.3.1"
gem "will_paginate"
# Use SCSS for stylesheets
gem "jbuilder", "~> 2.7"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false
gem "jquery-rails"
gem "rubocop", require: false
gem "rubocop-minitest", require: false
gem "rubocop-performance"
gem "rubocop-rails"
gem "rubocop-rspec", require: false
gem "ruby-progressbar"
gem "yaml_db"

# gem devise omniauth
gem "devise"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"

# gem comment post
gem "closure_tree"
gem "private_pub"

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "factory_bot_rails"
  gem "mysql2", "~>0.5.3"
  gem "rspec-rails"
  gem "shoulda-matchers"
end

group :development do
  gem "guard"
  gem "guard-minitest"
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "database_cleaner-active_record"
  gem "minitest"
  gem "minitest-reporters"
  gem "rails-controller-testing"
  gem "rexml", "~>3.2.3"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "aws-sdk-s3", "1.46.0", require: false
  gem "pg", "1.2.3"
end

gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
