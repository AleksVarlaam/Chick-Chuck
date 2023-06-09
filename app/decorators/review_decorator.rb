# frozen_string_literal: true

class ReviewDecorator < ApplicationDecorator
  delegate_all

  def star_color(params, i)
    if params[:star_rating].present?
      (0..params[:star_rating].to_i).include?(i) ? 'text-yellow-400' : 'text-gray-400'
    else
      (0..review.rating).include?(i) ? 'text-yellow-400' : 'text-gray-400'
    end
  end

  def price_color(params, i)
    price = params[:price_rating].present? ? params[:price_rating].to_i : review.price
    case price
    when 0..3
      (0..price).include?(i) ? 'text-green-600' : 'text-gray-400'
    when 3..4
      (0..price).include?(i) ? 'text-yellow-400' : 'text-gray-400'
    when 4..5
      (0..price).include?(i) ? 'text-red-400' : 'text-gray-400'
    end
  end

  def star_value(params)
    params[:star_rating].to_i.positive? ? params[:star_rating].to_i : review.rating
  end

  def price_value(params)
    params[:price_rating].to_i.positive? ? params[:price_rating].to_i : review.price
  end

  def created_at
    l review.created_at, format: :date
  end

  def updated_at
    l review.updated_at, format: :date
  end
end
