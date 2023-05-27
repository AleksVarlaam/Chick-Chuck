# frozen_string_literal: true

class CompanyDecorator < ApplicationDecorator
  def created_at
    "#{User.human_attribute_name('created_at')}: #{l company.created_at, format: :date}"
  end
  
  def reviews_hash
    reviews = company.reviews

    {
      politeness: (reviews.map { |rev| [rev.politeness.to_f].sum / company.reviews.count }).sum || 0,
      punctuality: (reviews.map { |rev| [rev.punctuality.to_f].sum / company.reviews.count }).sum || 0,
      sociability: (reviews.map { |rev| [rev.sociability.to_f].sum / company.reviews.count }).sum || 0,
      wholeness_things: (reviews.map { |rev| [rev.wholeness_things.to_f].sum / company.reviews.count }).sum || 0,
      speed: (reviews.map { |rev| [rev.speed.to_f].sum / company.reviews.count }).sum || 0,
      value_money: (reviews.map { |rev| [rev.value_money.to_f].sum / company.reviews.count }).sum || 0
    }
  end

  def comments_count
    count = company.comments.count

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
      when 1          then "#{count} הערה"
      when 0, 2..nil  then "#{count} הערות"
      end
    end
  end

  def reviews_count
    count = company.reviews.count

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
      when 1          then "#{count} תגובה"
      when 0, 2..nil  then "#{count} תגובות"
      end
    end
  end
end
