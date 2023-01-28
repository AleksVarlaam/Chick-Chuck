# frozen_string_literal: true

module Feedbacks
  class ReviewsController < ApplicationController
    include ReviewsHelper
    before_action :authenticate_client!
    before_action :set_reviewable
    before_action :set_review, only: %i[edit update]
    before_action :limit_review, only: %i[new create]

    def new
      @review = Review.new
    end

    def create
      @review = @reviewable.reviews.build(review_params)
      @review.user_id = current_client.id if client_signed_in?

      respond_to do |format|
        if @review.save
          set_truck_rating(@reviewable)
          set_company_rating(@reviewable.user_id)
          format.turbo_stream { flash.now[:success] = 'Review created!' }
        else
          format.html { redirect_to @reviewable, alert: 'Something went wrong' }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @review.update(review_params)
          set_truck_rating(@reviewable)
          set_company_rating(@reviewable.user_id)
          format.turbo_stream { flash.now[:success] = 'Review updated!' }
        else
          format.html { redirect_to @reviewable, alert: 'Something went wrong' }
        end
      end
    end

    private

    def review_params
      params.require(:review).permit(:politeness, :punctuality, :sociability, :wholeness_things, :speed,
                                     :value_money)
    end

    def set_reviewable
      @reviewable = Truck.find_by_id(params[:truck_id]) if params[:truck_id].present?
    end

    def set_review
      @review = Review.find_by_id(params[:id])
    end
  end
end
