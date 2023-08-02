# frozen_string_literal: true

class StatisticDecorator < ApplicationDecorator
  delegate_all

  def visits_count
    visits_count = Statistic.first.main

    if (1000..999_999).include?(visits_count)
      visits_count = (visits_count.to_f / 1000).round(1).to_s
      case I18n.locale
      when :ru then "#{visits_count} тыс."
      when :uk then "#{visits_count} тис."
      when :en, :he then "#{visits_count} K"
      end
    elsif visits_count >= 1_000_000
      visits_count = (visits_count.to_f / 1_000_000).round(1).to_s
      case I18n.locale
      when :ru, :uk then "#{visits_count} млн."
      when :en, :he then "#{visits_count} M"
      end
    else
      visits_count
    end
  end
end
