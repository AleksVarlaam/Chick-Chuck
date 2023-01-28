# frozen_string_literal: true

class CompanyDecorator < ApplicationDecorator
  def comments_count
    count = company.trucks.map { |truck| truck.comments.count }.sum

    case I18n.locale
    when :en then "#{count} Comments"
    when :ru
      case count
      when 1          then "#{count} Комментарий"
      when 2, 3, 4    then "#{count} Комментария"
      when 0, 4..nil  then "#{count} Комментариев"
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
    when :he
      case count
      when 1          then "#{count} Отзыв"
      when 2, 3, 4    then "#{count} Отзыва"
      when 0, 4..nil  then "#{count} Отзывов"
      end
    end
  end
end
