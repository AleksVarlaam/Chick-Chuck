# frozen_string_literal: true

module Admins
  module Catalog
    class ThingsController < ApplicationController
      layout 'profile_layout'
      before_action :authenticate_admin!
      before_action :set_thing, only: %i[edit update destroy]
      before_action :set_category

      def new
        @thing = @category.things.new
      end

      def create
        @thing = @category.things.build(thing_params).decorate
        respond_to do |format|
          if @thing.save
            format.turbo_stream do
              flash.now[:success] =
                t('flash.success.created', model: "#{@thing.model_name.human} #{@thing.title.downcase}")
            end
          else
            format.html { render :new, target: helpers.dom_id(@category, 'thing_form'), status: :unprocessable_entity }
          end
        end
      end

      def index
        @things = @category.things.decorate
      end

      def edit; end

      def update
        respond_to do |format|
          if @thing.update(thing_params)
            format.turbo_stream do
              flash.now[:success] =
                t('flash.success.updated', model: "#{@thing.model_name.human} #{@thing.title.downcase}")
            end
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        respond_to do |format|
          if @thing.destroy
            format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @thing.model_name.human) }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      private

      def thing_params
        params.require(:thing).permit(:ru, :en, :he, :uk)
      end

      def set_category
        @category = Category.find_by_id(params[:category_id])
      end

      def set_thing
        @thing = Thing.find_by_id(params[:id]).decorate
      end
    end
  end
end
