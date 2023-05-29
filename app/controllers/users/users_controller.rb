# frozen_string_literal: true

module Users
  class UsersController < ApplicationController
    include Feedbacks::ReviewsHelper
    include PricesHelper
    before_action :set_user, only: %i[show modal contacts]

    def show
      return redirect_to root_path unless @user.instance_of?(Company)

      @commentable = @user
      @comment = Comment.new
      @reviewable = @user
      @review = current_client&.company_review(@reviewable) || Review.new
      @pagy, @reviews = pagy(@user.reviews, items: 10, fragment: '#reviews')
      @reviews_count = @user.reviews.count
    end

    def modal; end

    def contacts
      return redirect_to new_client_session_path, alert: t('devise.failure.unauthenticated') unless user_signed_in?
    end

    private

    def filter_params
      params.permit(:district_id, :body_type)
    end

    def set_user
      @user = User.find(params[:user_id] || params[:id])
    end
  end
end
