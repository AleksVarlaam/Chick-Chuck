# frozen_string_literal: true

module Contents
  class CompaniesController < ApplicationController
    include Feedbacks::ReviewsHelper
    include PricesHelper
    before_action :set_company, only: %i[show modal contacts calculator_modal]

    def show
      trucks = Truck.filter(filter_params)
      @pagy, @trucks = pagy(trucks, items: 8, fragment: '#trucks')
    end

    def modal; end

    def contacts; end

    def calculator_modal
      @categories = Category.all.decorate
    end

    private

    def filter_params
      params.permit(:district_id, :body_type)
    end

    def set_company
      @company = Company.find_by_id(params[:id])
    end
  end
end
