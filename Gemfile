# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Default gems
ruby '3.2.0'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

gem 'bootsnap', require: false
gem 'devise'
gem 'draper'
gem 'file_validators'
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

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'ffaker'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem "letter_opener"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  gem 'rubocop', require: false

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
