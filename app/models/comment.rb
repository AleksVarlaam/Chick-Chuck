# frozen_string_literal: true

class Comment < ApplicationRecord
  include ImagesAttachments
  self.table_name = 'comments'
  validates :content, presence: true, length: { minimum: 1 }

  belongs_to :user
  belongs_to :object, polymorphic: true
  belongs_to :commentable, polymorphic: true

  has_many   :comments, as: :commentable, dependent: :destroy

  has_noticed_notifications

  after_create_commit :notify_user

  def notify_user
    case commentable_type
    when Truck.name
      CommentNotification.with(comment: self).deliver_later(commentable.company) if user != commentable.company
    when News.name
      CommentNotification.with(comment: self).deliver_later(commentable.admin) if user != commentable.admin
    else
      CommentNotification.with(comment: self).deliver_later(commentable.user) if user != commentable.user
    end
  end
end
