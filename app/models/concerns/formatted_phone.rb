# frozen_string_literal: true

module FormattedPhone
  extend ActiveSupport::Concern

  included do
    before_save :normalize_phone

    validates :phone, phone: true, allow_blank: true
    validates :additional_phone, phone: true, allow_blank: true
    validates :whatsapp, phone: true, allow_blank: true

    def formatted_phone
      parsed_phone = Phonelib.parse(phone)
      return phone if parsed_phone.invalid?

      formatted =
        if parsed_phone.country_code == '1'
          parsed_phone.full_national
        else
          parsed_phone.full_international
        end
      formatted.gsub!(';', ' x')
      formatted
    end

    def formatted_additional_phone
      parsed_additional_phone = Phonelib.parse(additional_phone)
      return additional_phone if parsed_additional_phone.invalid?

      formatted =
        if parsed_additional_phone.country_code == '1'
          parsed_additional_phone.full_national
        else
          parsed_additional_phone.full_international
        end
      formatted.gsub!(';', ' x')
      formatted
    end

    def formatted_whatsapp
      parsed_whatsapp = Phonelib.parse(whatsapp)
      return whatsapp if parsed_whatsapp.invalid?

      formatted =
        if parsed_whatsapp.country_code == '1'
          parsed_whatsapp.full_national
        else
          parsed_whatsapp.full_international
        end
      formatted.gsub!(';', ' x')
      formatted
    end

    private

    def normalize_phone
      self.phone = Phonelib.parse(phone).full_e164.presence
      self.additional_phone = Phonelib.parse(additional_phone).full_e164.presence
      self.whatsapp = Phonelib.parse(whatsapp).full_e164.presence
    end
  end
end
