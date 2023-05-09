# frozen_string_literal: true

module Contents
  class ProductsController < ApplicationController
    include Feedbacks::ReviewsHelper
    before_action :set_show, only: :show
    before_action :params_for_select, only: %i[index user_products]

    def index
      Statistic.first.update(market: Statistic.first.market + 1) unless user_signed_in?
      total_products = Product.filter(filter_params).newest
      @pagy, @products = pagy(total_products, items: 11, fragment: '#products')
      @products = @products.decorate
      @products = @products.select { |product| product.user.type == params[:seller] } if params[:seller].present?
      @products_count = total_products.count
    end

    def show; end

    def user_products
      @user = User.find(params[:user_id])
      total_products = Product.user_products_filter(@user, filter_params).newest
      @pagy, @products = pagy(total_products, items: 11, fragment: '#products')
      @products = @products.decorate
      @products_count = total_products.count
    end

    private

    def filter_params
      params.permit(:category_id, :thing_id, :district_id, :city_id, :price_min, :price_max, :condition, :delivery)
    end

    def set_show
      @product = Product.find_by_id(params[:id]).decorate
      @user = User.find(@product.user_id)

      return if @user == current_user

      @product.update(views: @product.views + 1)
    end

    def params_for_select
      @categories = Category.all.decorate
      @districts = District.where.not(en: 'All Israel').decorate
    end
  end
end
