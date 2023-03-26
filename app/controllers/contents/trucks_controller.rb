# frozen_string_literal: true

module Contents
  class TrucksController < ApplicationController
    include Feedbacks::ReviewsHelper
    before_action :set_show, only: :show

    def index
      Statistic.first.update(trucks: Statistic.first.trucks + 1) unless user_signed_in?
      trucks = Truck.filter(filter_params)
      @top_trucks = trucks.take(3)
      @pagy_a, @trucks = pagy_array(trucks.drop(3), items: 4, fragment: '#trucks')
    end

    def company_trucks
      @company = Company.find(params[:company_id])
      @pagy, @trucks = pagy_array(Truck.company_trucks_filter(@company, filter_params), items: 4, fragment: '#trucks')
    end

    def show; end

    private

    def filter_params
      params.permit(:district_id, :body_type)
    end

    def set_show
      @truck = Truck.find_by_id(params[:id])
      truck_reviews_count(@truck)
      @commentable = @truck
      @comment = Comment.new
      @rating = Review.new
      @pagy, @comments = pagy(@truck.comments.where(commentable_type: Truck.name).newest, items: 10,
                                                                                          fragment: '#comments')
      return if current_admin || current_company&.trucks&.include?(@truck)

      @truck.update(views: @truck.views + 1)
    end
  end
end
