# frozen_string_literal: true

class CityDecorator < ApplicationDecorator
  delegate_all

  def title
    case I18n.locale
    when :ru then city.ru
    when :uk then city.uk
    when :en then city.en
    when :he then city.he
    end
  end
  
  def district_name
    case I18n.locale
    when :ru then city.district.ru
    when :uk then city.district.uk
    when :en then city.district.en
    when :he then city.district.he
    end
  end
end
