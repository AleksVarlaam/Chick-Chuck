# frozen_string_literal: true

class Client < User
  def avatar_attachment_path
    if avatar.attached?
      avatar.variant(:avatar)
    else
      gender == 'Male' ? 'icons/avatar-m.png' : 'icons/avatar-f.png'
    end
  end

  def truck_review(truck)
    Review.find_by(user_id: self, reviewable_id: truck)
  end

  def user_name
    return "#{first_name&.capitalize} #{last_name&.capitalize}" if first_name.present?

    email.split('@')[0].capitalize
  end
end
