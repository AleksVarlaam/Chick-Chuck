# frozen_string_literal: true

module Companies
  class PricesController < ApplicationController
    include PricesHelper
    layout 'profile_layout'
    before_action :authenticate_company!
    before_action :set_thing, only: %i[index create update]

    def index
      @categories = Category.all.decorate
    end

    def create
      @price = @thing.prices.build(price_params)
      @price.user_id = current_company.id
      respond_to do |format|
        if @price.save
          format.turbo_stream { flash.now[:success] = t('flash.success.created', model: @price.model_name.human) }
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    def update
      @price = Price.find_by(id: params[:id])
      respond_to do |format|
        if @price.update(price_params)
          format.turbo_stream { flash.now[:success] = t('flash.success.updated', model: @price.model_name.human) }
        else
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    private

    def price_params
      params.require(:price).permit(:amount)
    end

    def set_thing
      @thing = Thing.find_by_id(params[:thing_id])&.decorate
    end
  end
end
