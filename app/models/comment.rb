# frozen_string_literal: true

class Comment < ApplicationRecord
  self.table_name = 'comments'
  validates :content, presence: true, length: { minimum: 1 }

  belongs_to :user
  belongs_to :object, polymorphic: true
  belongs_to :commentable, polymorphic: true
  has_many :images,   as: :imageable,   dependent: :destroy, class_name: 'Image'
  accepts_nested_attributes_for :images

  has_many   :comments, as: :commentable, dependent: :destroy

  has_noticed_notifications

  after_create_commit :notify_user

  def notify_user
    case commentable_type
    when News.name
      CommentNotification.with(comment: self).deliver_later(commentable.admin) if user != commentable.admin
    when User.name
      CommentNotification.with(comment: self).deliver_later(commentable) if user != commentable
    else
      CommentNotification.with(comment: self).deliver_later(Admin.first) if user != Admin.first
    end
  end
end
