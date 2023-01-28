# frozen_string_literal: true

module Feedbacks
  module ReviewsHelper
    protected

    def limit_review
      user_review = current_client.truck_review(@reviewable) if client_signed_in?

      redirect_to edit_truck_review_path(@reviewable, user_review) if user_review.present?
    end

    def create_or_update_review(truck)
      user_review = current_client.truck_review(truck) if client_signed_in?

      if user_review.present?
        link_to(t('review.edit_btn'), edit_truck_review_path(truck, user_review),
                class: '',
                data: { turbo_frame: dom_id(truck, 'review_form') })
      else
        link_to(t('review.add_btn'), new_truck_review_path(truck),
                class: '',
                data: { turbo_frame: dom_id(truck, 'review_form') })
      end
    end

    def truck_reviews_count(truck)
      reviews = Review.where(reviewable_id: truck.id) if truck.present?

      @reviews_hash = {
        politeness: (reviews.map { |rev| [rev.politeness.to_f].sum / truck.reviews.count }).sum || 0,
        punctuality: (reviews.map { |rev| [rev.punctuality.to_f].sum / truck.reviews.count }).sum || 0,
        sociability: (reviews.map { |rev| [rev.sociability.to_f].sum / truck.reviews.count }).sum || 0,
        wholeness_things: (reviews.map { |rev| [rev.wholeness_things.to_f].sum / truck.reviews.count }).sum || 0,
        speed: (reviews.map { |rev| [rev.speed.to_f].sum / truck.reviews.count }).sum || 0,
        value_money: (reviews.map { |rev| [rev.value_money.to_f].sum / truck.reviews.count }).sum || 0
      }

      @total_truck_rating = (@reviews_hash.values.sum / 6).round(1)
    end

    def set_truck_rating(truck)
      truck_reviews_count(truck)
      truck.update(rating: @total_truck_rating)
    end

    def set_company_rating(user_id)
      company = Company.find_by_id(user_id)
      ratings = []
      company.trucks.each { |truck| ratings << truck.rating.to_f if truck.rating.positive? }
      total_company_rating = (ratings.sum / ratings.count).round(1)
      company.update(rating: total_company_rating)
    end

    def rating_bar(review)
      rating_bar = review.present? ? review * 10 : 0
    end
  end
end
