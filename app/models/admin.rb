# frozen_string_literal: true

class Admin < User
  has_many :news, class_name: 'News', foreign_key: :user_id

  def avatar_thumb
    avatar.present? ? avatar.thumb.url : 'icons/avatar-m.png'
  end

  def user_name
    first_name.present? ? "Admin #{first_name}" : 'Admin'
  end
end
