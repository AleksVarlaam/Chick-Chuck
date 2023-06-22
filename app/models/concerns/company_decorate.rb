# frozen_string_literal: true

module CompanyDecorate
  extend ActiveSupport::Concern

  included do
    # Decorators  
    def user_name
      title
    end
    
    def avatar_thumb
      avatar.present? ? avatar.thumb.url : 'icons/chick-chuck/og-chick-chuck.png'
    end
  
    def avatar_medium
      avatar.present? ? avatar.medium.url : 'icons/chick-chuck/og-chick-chuck.png'
    end
  
    def avatar_large
      avatar.present? ? avatar.large.url : 'icons/chick-chuck/og-chick-chuck.png'
    end
  end
end
