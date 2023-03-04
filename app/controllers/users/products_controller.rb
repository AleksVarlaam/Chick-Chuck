# frozen_string_literal: true

module Users
  class ProductsController < ApplicationController
    include Feedbacks::ReviewsHelper
    layout 'profile_layout'
    before_action :authenticate_user!
    before_action :set_product, only: %i[edit update publish mark_as_sold destroy]
    before_action :filter_product, only: %i[new create edit update]

    def index
      @pagy, @products = pagy(current_user.products.newest, items: 8, fragment: '#products')
      @products = @products.decorate
    end

    def new
      @product = current_user.products.new.decorate
    end

    def create
      @product = current_user.products.build(product_params).decorate

      respond_to do |format|
        if @product.save
          format.html do
            redirect_to users_products_path,
                        success: t('flash.success.created', model: "#{@product.model_name.human} #{@product.title}")
          end
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.turbo_stream do
            flash.now[:success] = t('flash.success.updated', model: "#{@product.model_name.human} #{@product.title}")
          end
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def publish
      return unless current_user.products.include?(@product)

      respond_to do |format|
        if @product.published == false
          if @product.update(published: true)
            format.turbo_stream do
              flash.now[:success] =
                t('flash.success.published', model: "#{@product.model_name.human} #{@product.title}")
            end
          end
        elsif @product.update(published: false)
          format.turbo_stream do
            flash.now[:success] = t('flash.success.hided', model: "#{@product.model_name.human} #{@product.title}")
          end
        end
      end
    end

    def mark_as_sold
      return unless current_user.products.include?(@product)

      respond_to do |format|
        if @product.sold == false
          @product.update(sold: true, published: false)
          format.turbo_stream do
            flash.now[:success] = t('flash.success.hided', model: "#{@product.model_name.human} #{@product.title}")
          end
        else
          @product.update(sold: false, published: true)
          format.turbo_stream do
            flash.now[:success] =
              t('flash.success.published', model: "#{@product.model_name.human} #{@product.title}")
          end
        end
      end
    end

    def destroy
      respond_to do |format|
        if @product.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @product.model_name.human) }
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    private

    def product_params
      params.require(:product).permit(:category_id, :thing_id, :title, :condition, :delivery, :description, :price, images: [],
                                                                                                         append_images: [])
    end

    def filter_product
      @categories = Category.all.decorate
      @things = Category.find_by(id: params[:category_id])&.things&.decorate || @product&.category&.things&.decorate || Thing.all.decorate
    end

    def set_product
      @product = Product.find_by_id(params[:product_id] || params[:id]).decorate
    end
  end
end
