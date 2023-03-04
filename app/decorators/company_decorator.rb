# frozen_string_literal: true

class CompanyDecorator < ApplicationDecorator
  def created_at
    "#{User.human_attribute_name('created_at')}: #{l company.created_at, format: :date}"
  end

  def comments_count
    count = Comment.where(object: company).count

    case I18n.locale
    when :en then "#{count} Comments"
    when :ru
      case count
      when 1          then "#{count} Комментарий"
      when 2, 3, 4    then "#{count} Комментария"
      when 0, 4..nil  then "#{count} Комментариев"
      end
    when :uk
      case count
      when 1          then "#{count} Коментар"
      when 2, 3, 4    then "#{count} Коментара"
      when 0, 4..nil  then "#{count} Коментарів"
      end
    when :he
      case count
      when 1          then "#{count} Комментарий"
      when 2, 3, 4    then "#{count} Комментария"
      when 0, 4..nil  then "#{count} Комментариев"
      end
    end
  end

  def reviews_count
    count = company.trucks.map { |truck| truck.reviews.count }.sum

    case I18n.locale
    when :en then "#{count} Reviews"
    when :ru
      case count
      when 1          then "#{count} Отзыв"
      when 2, 3, 4    then "#{count} Отзыва"
      when 0, 4..nil  then "#{count} Отзывов"
      end
    when :uk
      case count
      when 1          then "#{count} Відгук"
      when 2, 3, 4    then "#{count} Відгука"
      when 0, 4..nil  then "#{count} Відгуків"
      end
    when :he
      case count
      when 1          then "#{count} Отзыв"
      when 2, 3, 4    then "#{count} Отзыва"
      when 0, 4..nil  then "#{count} Отзывов"
      end
    end
  end
end
