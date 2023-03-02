# frozen_string_literal: true

class Client < User
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  has_many :products, class_name: 'Product', dependent: :destroy, foreign_key: :user_id

  def self.from_omniauth(auth)
    name_split = auth.info.name.split(' ')

    user = Client.where(email: auth.info.email).first
    user ||= Client.create!(
      provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], confirmed_at: Time.now,
      first_name: name_split.first, last_name: name_split.last
    )

    if user.avatar != auth.info.image
      require 'open-uri'

      user.avatar.attach(io: URI.parse(auth.info.image).open, filename: "user_#{user.id}_avatar")
      user.save
    end
    user
  end

  def truck_review(truck)
    Review.find_by(user_id: self, reviewable_id: truck)
  end

  # Mailer
  def after_confirmation
    Subscriber.create(email:) unless Subscriber.where(email:).present?
  end

  # Decorators

  def avatar_attachment_path
    if avatar.attached?
      avatar.variant(:avatar)
    else
      gender == 'female' ? 'icons/avatar-f.png' : 'icons/avatar-m.png'
    end
  end

  def user_name
    return "#{first_name&.capitalize} #{last_name&.capitalize}" if first_name.present?

    email.split('@')[0].capitalize
  end
end
