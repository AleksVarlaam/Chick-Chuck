# frozen_string_literal: true

class DistrictDecorator < ApplicationDecorator
  delegate_all

  def title
    case I18n.locale
    when :ru then district.ru
    when :en then district.en
    when :he then district.he
    end
  end
end
