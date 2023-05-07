# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Default gems
ruby '3.2.1'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

gem 'bootsnap', require: false
gem 'carrierwave', '>= 3.0.0.beta', '< 4.0'
gem 'devise'
gem 'devise-i18n'
gem 'draper'
gem 'file_validators'
gem 'fog-aws'
gem 'image_processing', '~> 1.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'noticed', '~> 1.6'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy', '~> 6.0'
gem 'pg', '~> 1.1'
gem 'phonelib'
gem 'puma', '~> 6.0'
gem 'rails_heroicon'
gem 'rails-i18n', '~> 7.0.0'
gem 'redis', '~> 5.0'
gem 'sassc-rails'
gem 'sidekiq', '~> 7.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'view_component', '~> 2.74'
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'ffaker'
  gem 'letter_opener'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
end

group :development do
  gem 'web-console'
  gem 'rubocop', require: false
end
