# frozen_string_literal: true

module Users
  class UsersController < ApplicationController
    include Feedbacks::ReviewsHelper
    include PricesHelper
    before_action :set_user, only: %i[show modal contacts]

    def show
      @commentable = @user
      @comment = Comment.new
      @pagy, @comments = pagy(Comment.where(commentable: @user).newest, items: 10, fragment: '#comments')
      @comments_count = Comment.where(object: @user).count
    end

    def modal; end

    def contacts; end

    private

    def filter_params
      params.permit(:district_id, :body_type)
    end

    def set_user
      @user = User.find(params[:user_id] || params[:id])
    end
  end
end
