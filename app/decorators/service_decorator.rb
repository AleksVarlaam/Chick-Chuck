# frozen_string_literal: true

class ServiceDecorator < ApplicationDecorator
  delegate_all

  def title
    case I18n.locale
    when :ru then service.ru
    when :uk then service.uk
    when :en then service.en
    when :he then service.he
    end
  end
end
