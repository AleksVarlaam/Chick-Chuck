# frozen_string_literal: true

class User < ApplicationRecord
  include Login
  include FormattedPhone
  include Notificable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable,
         :validatable, authentication_keys: [:login]

  validates :first_name, :last_name, :city, allow_blank: true, length: { in: 2..25 }
  validates :avatar, file_size: { less_than_or_equal_to: 10.megabytes },
                     file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

  has_one_attached :avatar, dependent: :purge do |attachable|
    attachable.variant(:avatar, resize_to_limit: [100, 100], convert: 'webp')
  end
  has_and_belongs_to_many :rooms, class_name: 'Room', dependent: :destroy
  has_many :comments, class_name: 'Comment', dependent: :destroy
  has_many :messages, class_name: 'Message', dependent: :destroy

end
