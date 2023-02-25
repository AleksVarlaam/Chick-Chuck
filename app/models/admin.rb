# frozen_string_literal: true

class Admin < User
  include AdminDbParams
  has_many :news, class_name: 'News', foreign_key: :user_id

  def avatar_attachment_path
    avatar.attached? ? avatar.variant(:avatar) : 'icons/avatar-m.png'
  end

  def user_name
    first_name.present? ? "Admin #{first_name}" : 'Admin'
  end
  
end
