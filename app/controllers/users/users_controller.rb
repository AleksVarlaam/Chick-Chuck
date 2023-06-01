# frozen_string_literal: true

module Users
  class UsersController < ApplicationController
    include Feedbacks::ReviewsHelper
    include PricesHelper
    before_action :set_user, only: %i[show modal contacts]
    after_action :update_views, only: :show
    
    def index
      Statistic.first.update(market: Statistic.first.companies + 1) unless user_signed_in?
      companies = Company.user_filter(filter_params)
      @best_companies = companies.take(3)
      latest_companies = companies.drop(3)
      @pagy_a, @latest_companies = pagy_array(latest_companies, items: 10)
      @companies_count = latest_companies.count
    end

    def show
      return redirect_to root_path unless @user.instance_of?(Company)

      @commentable = @user
      @comment = Comment.new
      @reviewable = @user
      @review = current_client&.company_review(@reviewable) || Review.new
      @reviews = @user.reviews.where.not(content: nil || "", title: nil || "")
      @pagy, @reviews = pagy(@reviews, items: 10, fragment: '#reviews')
      @reviews_count = @reviews.count
    end

    def modal; end

    def contacts
      return redirect_to new_client_session_path, alert: t('devise.failure.unauthenticated') unless user_signed_in?
    end

    private

    def filter_params
      params.permit(:district_id, :language_id)
    end

    def set_user
      @user = User.find(params[:user_id] || params[:id])
    end
    
    def update_views
      return if current_admin || current_company == @user

      @user.update(views: @user.views + 1)
    end
  end
end
