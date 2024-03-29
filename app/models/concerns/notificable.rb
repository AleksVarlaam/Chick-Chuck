# frozen_string_literal: true

module Notificable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :recipient, dependent: :destroy

    def unviewed_notifications_count
      notifications.unviewed.count
    end

    def unviewed_messages_count
      notifications.unviewed_messages.count
    end

    def send_devise_notification(notification, *args)
      I18n.with_locale(locale) { super(notification, *args) }
    end
  end
end
