# frozen_string_literal: true

class ProductDecorator < ApplicationDecorator
  delegate_all

  def created_at
    l product.created_at, format: :short
  end

  def category_name
    case I18n.locale
    when :ru then product.category.ru
    when :uk then product.category.uk
    when :en then product.category.en
    when :he then product.category.he
    end
  end

  def thing_name
    case I18n.locale
    when :ru then product.thing.ru
    when :uk then product.thing.uk
    when :en then product.thing.en
    when :he then product.thing.he
    end
  end

  def condition_name
    Product.condition_select.select { |item| return item[0] if item[1] == product.condition }
  end
end
