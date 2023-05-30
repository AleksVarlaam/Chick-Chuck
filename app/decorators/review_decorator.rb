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
  
  def created_at
    l review.created_at, format: :date
  end
  
  def updated_at
    l review.updated_at, format: :date
  end
end
