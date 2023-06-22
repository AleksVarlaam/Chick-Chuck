# frozen_string_literal: true

class Client < User
  include ClientDecorate
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :products, class_name: 'Product', dependent: :destroy, foreign_key: :user_id

  def self.from_omniauth(auth)
    name_split = auth.info.name.split(' ')

    user = Client.where(email: auth.info.email).first
    user ||= Client.create!(
      provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], confirmed_at: Time.now,
      first_name: name_split.first, last_name: name_split.last
    )

    # if user.remote_avatar_url != auth.info.image
    #       require 'open-uri'
    #
    #       user.remote_avatar_url = auth.info.image
    #       user.save
    #     end
    user
  end

  def company_review(company)
    Review.find_by(user_id: self, reviewable_id: company)
  end

  # Mailer
  def after_confirmation
    Subscriber.create(email:) unless Subscriber.where(email:).present?
  end

end
