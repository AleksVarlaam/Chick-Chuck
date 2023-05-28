# frozen_string_literal: true

class Review < ApplicationRecord
  self.table_name = 'reviews'
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  has_noticed_notifications

  after_create_commit :notify_user

  def notify_user
    ReviewNotification.with(review: self).deliver_later(reviewable) if user != reviewable
  end
end
