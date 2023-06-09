# frozen_string_literal: true

class User < ApplicationRecord
  include Login
  include FormattedPhone
  include Notificable
  include Filterable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable,
         :validatable, authentication_keys: [:login]

  mount_uploader :avatar, AvatarUploader

  validates :first_name, :last_name, :city, allow_blank: true, length: { in: 2..25 }
  has_and_belongs_to_many :rooms, class_name: 'Room', dependent: :destroy
  has_many :comments, class_name: 'Comment', dependent: :destroy
  has_many :messages, class_name: 'Message', dependent: :destroy

  has_many :favorites, foreign_key: :user_id

  # Scopes
  scope :filter_by_type, ->(type) { where type: }
  scope :filter_by_user_name, ->(user_name) { User.all.select { |user| user.user_name == user_name } }
end
