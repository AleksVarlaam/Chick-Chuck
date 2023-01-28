# frozen_string_literal: true

module Contents
  class ProductsController < ApplicationController
    include Feedbacks::ReviewsHelper
    before_action :set_show, only: :show

    def index
      @categories = Category.all.decorate
      @selected_category = params[:category_id] || Thing.find_by(id: params[:thing_id])&.category&.id
      @things = things_select
      @pagy, @products = pagy(Product.filter(filter_params).newest, items: 8, fragment: '#products')
      @products = @products.decorate
    end

    def show; end

    private

    def filter_params
      params.permit(:category_id, :thing_id)
    end

    def set_show
      @product = Product.find_by_id(params[:id]).decorate
      @company = Company.find_by_id(@product.user_id)

      return if current_admin || current_company&.products&.include?(@product)

      @product.update(views: @product.views + 1)
    end

    def things_select
      if params[:thing_id].present?
        Thing.find_by(id: params[:thing_id])&.category&.things&.decorate
      elsif params[:category_id].present?
        Thing.where(category_id: params[:category_id]).decorate
      else
        Thing.all.decorate
      end
    end
  end
end
