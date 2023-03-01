# frozen_string_literal: true

class NewsDecorator < ApplicationDecorator
  delegate_all

  def created_at
    l news.created_at, format: :short
  end

  def comments_count
    case I18n.locale
    when :en then "#{news.comments.count} Comments"
    when :ru
      case news.comments.count
      when 1          then "#{news.comments.count} Комментарий"
      when 2, 3, 4    then "#{news.comments.count} Комментария"
      when 0, 4..nil  then "#{news.comments.count} Комментариев"
      end
    when :uk
      case news.comments.count
      when 1          then "#{news.comments.count} Коментар"
      when 2, 3, 4    then "#{news.comments.count} Коментара"
      when 0, 4..nil  then "#{news.comments.count} Коментарів"
      end
    when :he
      case news.comments.count
      when 1          then "#{news.comments.count} Комментарий"
      when 2, 3, 4    then "#{news.comments.count} Комментария"
      when 0, 4..nil  then "#{news.comments.count} Комментариев"
      end
    end
  end
end
