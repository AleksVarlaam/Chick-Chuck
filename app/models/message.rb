# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  mount_uploaders :images, ImageUploader

  scope :unread, -> { where(readed: false).count }

  has_noticed_notifications

  after_create_commit :notify_user

  def notify_user
    MessageNotification.with(message: self).deliver_later(recipient)
  end

  def recipient
    room.users.where.not(id: user_id)[0]
  end
end
