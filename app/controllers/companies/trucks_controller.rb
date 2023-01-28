# frozen_string_literal: true

module Companies
  class TrucksController < ApplicationController
    include Feedbacks::ReviewsHelper
    layout 'profile_layout'
    before_action :authenticate_company!
    before_action :set_truck, only: %i[edit update publish destroy]

    def index
      @pagy, @trucks = pagy(current_company.trucks, items: 8, fragment: '#trucks')
    end

    def new
      @truck = Truck.new.decorate
    end

    def create
      @truck = current_company.trucks.build(truck_params).decorate
      respond_to do |format|
        if @truck.save
          format.turbo_stream do
            flash.now[:success] = t('flash.success.created', model: "#{@truck.model_name.human} #{@truck.number}")
          end
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @truck.update(truck_params)
          format.turbo_stream do
            flash.now[:success] = t('flash.success.updated', model: "#{@truck.model_name.human} #{@truck.number}")
          end
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def publish
      return unless current_company.trucks.include?(@truck)

      respond_to do |format|
        if @truck.published == false
          if @truck.update(published: true)
            format.turbo_stream do
              flash.now[:success] = t('flash.success.published', model: "#{@truck.model_name.human} #{@truck.number}")
            end
          end
        elsif @truck.update(published: false)
          format.turbo_stream do
            flash.now[:success] = t('flash.success.hided', model: "#{@truck.model_name.human} #{@truck.number}")
          end
        end
      end
    end

    def destroy
      respond_to do |format|
        if @truck.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @truck.model_name.human) }
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_truck
      @truck = Truck.find_by_id(params[:id]).decorate
    end

    def truck_params
      params.fetch(:truck, {})
      params.require(:truck).permit({ district_ids: [] }, :body_type, :length, :width, :height, :load_capacity, :assembly, :packing, images: [],
                                                                                                                                     append_images: [])
    end
  end
end
