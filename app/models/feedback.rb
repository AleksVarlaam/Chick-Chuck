class Feedback < ApplicationRecord
  validates :usability, :speed, :design, :quality, numericality: { in: 0..5 }
  belongs_to :user
  
  has_noticed_notifications
  
  after_create_commit :notify_admin

  def notify_admin
    FeedbackNotification.with(feedback: self).deliver_later(Admin.first)
  end
end
