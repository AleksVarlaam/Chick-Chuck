# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Laavor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    
    # ActionMailer
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_url_options = { host: ENV['MAIL_HOST'] }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      user_name:      ENV['SENDMAIL_USERNAME'],
      password:       ENV['SENDMAIL_PASSWORD'],
      domain:         ENV['MAIL_HOST'],
      address:       'smtp.gmail.com',
      port:          '587',
      authentication: :plain,
      enable_starttls_auto: true
    }
    
    # ActiveJob adapter
    config.active_job.queue_adapter = :sidekiq
    
    # TimeZone
    config.time_zone = "Asia/Jerusalem"

    # I18n
    config.i18n.available_locales = %i[en ru he]
    config.i18n.default_locale = :en
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Active storage
    config.active_storage.replace_on_assign_to_many = false
  end
end
