# frozen_string_literal: true

module Contents
  class ProductsController < ApplicationController
    include Feedbacks::ReviewsHelper
    before_action :set_show, only: :show
    before_action :params_for_select, only: %i[index user_products]

    def index
      set_meta_tags(
        title: t('meta.market.title'),
        description: t('meta.market.desc'),
        keywords: Category.all.decorate.map(&:title).join(', ').sub(/(, )+$/, ''),
        canonical: products_url,
        noindex: request.original_url.include?('?') ? true : false
      )

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

      set_meta_tags(
        title: [t('pages.market'), @user.user_name],
        description: "#{t('about.market.title')}. #{t('home_page.main_features.market_desc')}",
        canonical: user_products_url(@user),
        noindex: request.original_url.include?('?') ? true : false
      )
    end

    private

    def filter_params
      params.permit(:category_id, :thing_id, :district_id, :city_id, :price_min, :price_max, :condition, :delivery)
    end

    def set_show
      @product = Product.find_by_id(params[:id]).decorate
      @user = User.find(@product.user_id)

      set_meta_tags(
        title: [t('pages.market'), @product.title],
        description: @product.description.to_s || "#{t('about.market.title')}. #{@product.category.decorate.title}. #{@product.thing.decorate.title}",
        keywords: "#{@product.category.decorate.title}, #{@product.thing.decorate.title}"
      )

      return if @user == current_user

      @product.update(views: @product.views + 1)
    end

    def params_for_select
      @categories = Category.where.not(en: 'Cartons').decorate
      @districts = District.where.not(en: 'All Israel').decorate
    end
  end
end
