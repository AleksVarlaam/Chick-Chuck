# frozen_string_literal: true

class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  default_scope { newest }
  scope :unviewed, -> { where.not(type: MessageNotification.name).where(read_at: nil) }
  scope :unviewed_messages, -> { where(type: MessageNotification.name, read_at: nil) }

  after_commit do
    if type == MessageNotification.name
      broadcast_replace_to "broadcast_to_user_#{recipient_id}",
                           target: 'messages_count',
                           partial: 'feedbacks/messages/notifications/count',
                           locals: { count: recipient.unviewed_messages_count }
    else
      broadcast_replace_to "broadcast_to_user_#{recipient_id}",
                           target: 'notifications_count',
                           partial: 'feedbacks/notifications/count',
                           locals: { count: recipient.unviewed_notifications_count }
    end
  end
end
