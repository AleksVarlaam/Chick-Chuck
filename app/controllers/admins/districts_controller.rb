# frozen_string_literal: true

module Admins
  class DistrictsController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_admin!
    before_action :set_district, only: %i[show edit update destroy]

    def new
      @district = District.new
    end

    def create
      @district = District.new(district_params).decorate
      respond_to do |format|
        if @district.save
          format.turbo_stream do
            flash.now[:success] =
              t('flash.success.created', model: "#{@district.model_name.human} #{@district.title.downcase}")
          end
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def index
      @districts = District.all.decorate.drop(1)
      @languages = Language.all
    end

    def edit; end

    def update
      respond_to do |format|
        if @district.update(district_params)
          format.turbo_stream do
            flash.now[:success] =
              t('flash.success.updated', model: "#{@district.model_name.human} #{@district.title.downcase}")
          end
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @district.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @district.model_name.human) }
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    private

    def district_params
      params.require(:district).permit(:ru, :en, :he, :uk)
    end

    def set_district
      @district = District.find_by_id(params[:id]).decorate
    end
  end
end
