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

  def district_name
    case I18n.locale
    when :ru then product.district.ru
    when :uk then product.district.uk
    when :en then product.district.en
    when :he then product.district.he
    end
  end

  def city_name
    case I18n.locale
    when :ru then product.city.ru
    when :uk then product.city.uk
    when :en then product.city.en
    when :he then product.city.he
    end
  end

  def delivery_name
    return I18n.t('product.delivery.pickup') if product.delivery.zero?

    district = District.find(product.delivery).decorate
    case I18n.locale
    when :ru then district.ru
    when :uk then district.uk
    when :en then district.en
    when :he then district.he
    end
  end

  def condition_name
    Product.condition_select.select { |item| return item[0] if item[1] == product.condition }
  end

  # def delivery_name
  #     case product.delivery
  #     when 1 then h.image_tag(h.asset_path('icons/icons8-done-40.png'), class: 'ml-2 w-5 h-5')
  #     when 2 then (h.heroicon 'x-mark', class: 'ml-2 w-5 h-5 text-red-700')
  #     end
  #   end
end
