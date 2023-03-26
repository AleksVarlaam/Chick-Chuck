# frozen_string_literal: true

module Contents
  class ProductsController < ApplicationController
    include Feedbacks::ReviewsHelper
    before_action :set_show, only: :show
    before_action :params_for_select, only: %i[index user_products]

    def index
      Statistic.first.update(products: Statistic.first.products + 1) unless user_signed_in?
      @pagy, @products = pagy(Product.filter(filter_params).newest, items: 8, fragment: '#products')
      @products = @products.decorate
    end

    def show; end

    def user_products
      @user = User.find(params[:user_id])
      @pagy, @products = pagy(Product.user_products_filter(@user, filter_params).newest, items: 8,
                                                                                         fragment: '#products')
      @products = @products.decorate
    end

    private

    def filter_params
      params.permit(:category_id, :thing_id)
    end

    def set_show
      @product = Product.find_by_id(params[:id]).decorate
      @user = User.find(@product.user_id)

      return if @user == current_user

      @product.update(views: @product.views + 1)
    end

    def params_for_select
      @categories = Category.all.decorate
      @selected_category = params[:category_id] || Thing.find_by(id: params[:thing_id])&.category&.id

      @things = if params[:thing_id].present?
                  Thing.find_by(id: params[:thing_id])&.category&.things&.decorate
                elsif params[:category_id].present?
                  Thing.where(category_id: params[:category_id]).decorate
                else
                  Thing.all.decorate
                end
    end
  end
end
