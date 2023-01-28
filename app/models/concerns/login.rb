# frozen_string_literal: true

module Login
  extend ActiveSupport::Concern

  included do
    # Login params
    attr_writer :login

    def login
      @login || phone || email
    end

    # Database authentication
    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if (login = conditions.delete(:login))
        where(conditions.to_h).where(['lower(phone) = :value OR lower(email) = :value',
                                      { value: login.downcase }]).first
      elsif conditions.key?(:phone) || conditions.key?(:email)
        where(conditions.to_h).first
      end
    end
  end
end
