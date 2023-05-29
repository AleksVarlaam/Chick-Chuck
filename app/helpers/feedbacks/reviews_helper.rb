# frozen_string_literal: true

module Feedbacks
  module ReviewsHelper
    protected

    def limit_review
      user_review = current_client.company_review(@reviewable) if client_signed_in?

      redirect_to edit_review_path(@reviewable, user_review) if user_review.present?
    end
    
    def existed_star(review, i)
      if params[:star_rating].present? 
        (0..params[:star_rating].to_i).include?(i) ? 'text-yellow-400' : 'text-gray-400'  
      elsif review.present?
        (00..review.rating).include?(i) ? 'text-yellow-400' : 'text-gray-400'  
      end
    end

    def create_or_update_review(company)
      user_review = current_client.company_review(company) if client_signed_in?

      if user_review.present?
        link_to(t('review.add_btn'), edit_review_path(user_review, company_id: company.id),
                class: 'text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center h-10 flex items-center',
                data: { turbo_frame: 'modal' })
      else
        link_to(t('review.add_btn'), new_review_path(company_id: company.id),
                class: 'text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center h-10 flex items-center',
                data: { turbo_frame: 'modal' })
      end
    end

    def set_company_rating(company)
      
      rating = (company.reviews.map {|review| review.rating}.sum / company.reviews.count).round(1)
      
      company.update(rating: rating)
    end

    def rating_bar(review)
      rating_bar = review.present? ? review * 10 : 0
    end
  end
end
