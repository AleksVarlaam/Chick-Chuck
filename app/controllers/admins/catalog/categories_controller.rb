# frozen_string_literal: true

module Admins
  module Catalog
    class CategoriesController < ApplicationController
      layout 'profile_layout'
      before_action :authenticate_admin!
      before_action :set_category, only: %i[edit update destroy]

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(category_params).decorate
        respond_to do |format|
          if @category.save
            format.turbo_stream do
              flash.now[:success] =
                t('flash.success.created', model: "#{@category.model_name.human} #{@category.title.downcase}")
            end
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      def index
        @categories = Category.all.decorate
      end

      def edit; end

      def update
        respond_to do |format|
          if @category.update(category_params)
            format.turbo_stream do
              flash.now[:success] =
                t('flash.success.updated', model: "#{@category.model_name.human} #{@category.title.downcase}")
            end
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        respond_to do |format|
          if @category.destroy
            format.turbo_stream do
              flash.now[:success] = t('flash.success.destroyed', model: @category.model_name.human)
            end
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      private

      def category_params
        params.require(:category).permit(:ru, :en, :he)
      end

      def set_category
        @category = Category.find_by_id(params[:id]).decorate
      end
    end
  end
end
