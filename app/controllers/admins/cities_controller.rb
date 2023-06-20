module Admins
  class CitiesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_admin!
    before_action :set_district
    before_action :set_city, only: %i[show edit update destroy]
    
    def index
      @cities = @district.cities.decorate
    end
    
    def new
      @city = @district.cities.new
    end
    
    def create
      @city = @district.cities.build(city_params).decorate
      respond_to do |format|
        if @city.save
          format.turbo_stream do
            flash.now[:success] =
              t('flash.success.created', model: "#{@city.model_name.human} #{@city.title.downcase}")
          end
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
    
    def edit; end

    def update
      respond_to do |format|
        if @city.update(city_params)
          format.turbo_stream do
            flash.now[:success] =
              t('flash.success.updated', model: "#{@city.model_name.human} #{@city.title.downcase}")
          end
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @city.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @city.model_name.human) }
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end
    
    private
    
    def city_params
      params.require(:city).permit(:ru, :en, :he, :uk)
    end
    
    def set_district
      @district = District.find_by_id(params[:district_id]).decorate
    end
    
    def set_city
      @city = City.find_by_id(params[:id]).decorate
    end
  end
end