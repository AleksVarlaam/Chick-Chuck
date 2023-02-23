# frozen_string_literal: true

class ThingDecorator < ApplicationDecorator
  delegate_all

  def title
    case I18n.locale
    when :ru then thing.ru
    when :uk then thing.uk
    when :en then thing.en
    when :he then thing.he
    end
  end
end
