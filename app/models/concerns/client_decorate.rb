# frozen_string_literal: true

module ClientDecorate
  extend ActiveSupport::Concern

  included do
    # Decorators
    def user_name
      return "#{first_name&.capitalize} #{last_name&.capitalize}" if first_name.present?

      email.split('@')[0].capitalize
    end

    def avatar_thumb
      if avatar.present?
        remote_avatar_url || avatar.thumb.url
      else
        gender == 'female' ? 'icons/avatar-f.png' : 'icons/avatar-m.png'
      end
    end

    def avatar_medium
      if avatar.present?
        remote_avatar_url || avatar.medium.url
      else
        gender == 'female' ? 'icons/avatar-f.png' : 'icons/avatar-m.png'
      end
    end

    def avatar_large
      if avatar.present?
        remote_avatar_url || avatar.large.url
      else
        gender == 'female' ? 'icons/avatar-f.png' : 'icons/avatar-m.png'
      end
    end
  end
end
