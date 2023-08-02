# frozen_string_literal: true

module CompanyDecorate
  extend ActiveSupport::Concern

  included do
    # Decorators
    def user_name
      title
    end

    def avatar_thumb
      avatar.present? ? avatar.thumb.url : '/android-chrome-512x512.png'
    end

    def avatar_medium
      avatar.present? ? avatar.medium.url : 'logo/og-chick-chuck.webp'
    end

    def avatar_large
      avatar.present? ? avatar.large.url : 'logo/og-chick-chuck.webp'
    end
  end
end
