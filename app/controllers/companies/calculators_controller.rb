# frozen_string_literal: true

module Companies
  class CalculatorsController < ApplicationController
    include PricesHelper
    layout 'profile_layout'
    before_action :authenticate_company!

    def create
      @calculator = Calculator.new(calculator_params)
      @calculator.user_id = current_company.id
      respond_to do |format|
        if @calculator.save
          format.turbo_stream { flash.now[:success] = t('flash.success.created', model: @calculator.model_name.human) }
        else
          format.html { render 'companies/prices/index', status: :unprocessable_entity }
        end
      end
    end

    def update
      @calculator = current_company.calculator
      respond_to do |format|
        if @calculator.update(calculator_params)
          format.turbo_stream { flash.now[:success] = t('flash.success.updated', model: @calculator.model_name.human) }
        else
          format.html { render 'companies/prices/index', status: :unprocessable_entity }
        end
      end
    end

    private

    def calculator_params
      params.require(:calculator).permit(:distance, :floor_down, :floor_up, :floor_down_elevator, :floor_up_elevator)
    end
  end
end
