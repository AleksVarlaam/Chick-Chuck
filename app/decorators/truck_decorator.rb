# frozen_string_literal: true

class TruckDecorator < ApplicationDecorator
  delegate_all

  def number
    "№ #{truck.company.title[0..1]}#{id}"
  end

  def comments_count
    case I18n.locale
    when :en then "#{truck.comments.count} Comments"
    when :ru
      case truck.comments.count
      when 1          then "#{truck.comments.count} Комментарий"
      when 2, 3, 4    then "#{truck.comments.count} Комментария"
      when 0, 4..nil  then "#{truck.comments.count} Комментариев"
      end
    when :uk
      case truck.comments.count
      when 1          then "#{truck.comments.count} Коментар"
      when 2, 3, 4    then "#{truck.comments.count} Коментара"
      when 0, 4..nil  then "#{truck.comments.count} Коментарів"
      end
    when :he
      case truck.comments.count
      when 1          then "#{truck.comments.count} הערה"
      when 0, 2..nil  then "#{truck.comments.count} הערות"
      end
    end
  end

  def reviews_count
    case I18n.locale
    when :en then "#{truck.reviews.count} Reviews"
    when :ru
      case truck.reviews.count
      when 1          then "#{truck.reviews.count} Отзыв"
      when 2, 3, 4    then "#{truck.reviews.count} Отзыва"
      when 0, 4..nil  then "#{truck.reviews.count} Отзывов"
      end
    when :uk
      case truck.reviews.count
      when 1          then "#{truck.reviews.count} Відгук"
      when 2, 3, 4    then "#{truck.reviews.count} Відгука"
      when 0, 4..nil  then "#{truck.reviews.count} Відгуків"
      end
    when :he
      case truck.reviews.count
      when 1          then "#{truck.reviews.count} תגובה"
      when 0, 2..nil  then "#{truck.reviews.count} תגובות"
      end
    end
  end

  def body_type_name
    Truck.body_type_select.select { |body| return body[0] if body[1] == truck.body_type }
  end

  def assembly_name
    Truck.assembly_select.select { |item| return item[0] if item[1] == truck.assembly }
  end

  def formatted_assembly
    case truck.assembly
    when 1 then h.image_tag(h.asset_path('icons/icons8-done-40.png'), class: 'w-5 h-5', alt: "icons8-done-40")
    when 2 then (h.heroicon 'x-mark', class: 'w-5 h-5 text-red-700')
    else
      h.tag.p assembly_name, class: 'text-gray-600 italic'
    end
  end

  def formatted_packing
    case truck.packing
    when 1 then h.image_tag(h.asset_path('icons/icons8-done-40.png'), class: 'w-5 h-5', alt: "icons8-done-40")
    when 2 then (h.heroicon 'x-mark', class: 'w-5 h-5 text-red-700')
    end
  end
end
