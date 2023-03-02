# frozen_string_literal: true

module Contents
  class CompaniesController < ApplicationController
    include Feedbacks::ReviewsHelper
    include PricesHelper
    before_action :set_company, only: %i[show modal contacts calculator_modal]

    def show
      @commentable = @company
      @comment = Comment.new
      @pagy, @comments = pagy(Comment.where(commentable_type: 'User', commentable_id: @company.id).newest, items: 10,
                                                                                          fragment: '#comments')
    end

    def modal; end

    def contacts; end

    def calculator_modal
      @categories = Category.all.decorate
    end

    private

    def filter_params
      params.permit(:district_id, :body_type)
    end

    def set_company
      @company = Company.find_by_id(params[:id])
    end
  end
end
