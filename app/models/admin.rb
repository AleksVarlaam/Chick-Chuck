# frozen_string_literal: true

class Admin < User
  has_many :news, class_name: 'News', foreign_key: :user_id

  def avatar_attachment_path
    avatar.attached? ? avatar.variant(resize_to_limit: [300, 300], convert: 'webp') : 'icons/avatar-m.png'
  end

  def user_name
    first_name.present? ? "Admin #{first_name}" : 'Admin'
  end
end
