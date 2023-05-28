# frozen_string_literal: true

module Contents
  class TrucksController < ApplicationController
    include Feedbacks::ReviewsHelper
    before_action :set_show, only: :show

    def index
      Statistic.first.update(trucks: Statistic.first.trucks + 1) unless user_signed_in?
      trucks = Truck.filter(filter_params)
      @top_trucks = trucks.take(3)
      latest_trucks = trucks.drop(3)
      @pagy, @trucks = pagy_array(latest_trucks, items: 8, fragment: '#trucks') if trucks.count > 3
      @trucks_count = latest_trucks.count
    end

    def company_trucks
      @company = Company.find(params[:company_id])
      trucks = Truck.company_trucks_filter(@company, filter_params)
      @pagy, @trucks = pagy_array(trucks, items: 8, fragment: '#trucks')
      @trucks_count = trucks.count
    end

    def show; end

    private

    def filter_params
      params.permit(:district_id, :body_type)
    end

    def set_show
      @truck = Truck.find_by_id(params[:id])
      @company = @truck.company
      @commentable = @company
      @comment = Comment.new
      @rating = Review.new
      @pagy, @comments = pagy(@company.comments.where(commentable_type: Company.name).newest, items: 10,
                                                                                          fragment: '#comments')
      return if current_admin || current_company&.trucks&.include?(@truck)

      @truck.update(views: @truck.views + 1)
    end
  end
end
