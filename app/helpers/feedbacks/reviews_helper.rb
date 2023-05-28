# frozen_string_literal: true

module Feedbacks
  module ReviewsHelper
    protected

    def limit_review
      user_review = current_client.company_review(@reviewable) if client_signed_in?

      redirect_to edit_review_path(@reviewable, user_review) if user_review.present?
    end

    def create_or_update_review(company)
      user_review = current_client.company_review(company) if client_signed_in?

      if user_review.present?
        link_to(t('review.edit_btn', model: Truck.model_name.human), edit_review_path(user_review, company_id: company.id),
                class: '',
                data: { turbo_frame: dom_id(company, 'review_form') })
      else
        link_to(t('review.add_btn', model: Truck.model_name.human), new_review_path(company_id: company.id),
                class: '',
                data: { turbo_frame: dom_id(company, 'review_form') })
      end
    end

    def set_company_rating(company)
      
      reviews_hash = company.decorate.reviews_hash

      total_company_rating = (reviews_hash.values.sum / 6).round(1)
      
      company.update(rating: total_company_rating)
    end

    def rating_bar(review)
      rating_bar = review.present? ? review * 10 : 0
    end
  end
end
