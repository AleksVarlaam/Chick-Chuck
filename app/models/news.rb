# frozen_string_literal: true

class News < ApplicationRecord
  validates :title, :description, :content, :images, presence: true

  mount_uploaders :images, ImageUploader
  belongs_to :admin, foreign_key: :user_id

  has_rich_text :content
  has_many :comments, as: :commentable, dependent: :destroy, class_name: 'Comment'
  has_many :comments, as: :object, dependent: :destroy, class_name: 'Comment'

  default_scope { order(created_at: :desc) }
end
