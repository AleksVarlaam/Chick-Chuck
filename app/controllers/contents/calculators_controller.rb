# frozen_string_literal: true

module Contents
  class CalculatorsController < ApplicationController
    include PricesHelper
    before_action :set_show, only: %i[show]

    def show
      Statistic.first.update(calculator: Statistic.first.calculator + 1) unless user_signed_in?
    end

    def company_calculator
      @company = Company.find_by_id(params[:company_id])
      @categories = Category.all.decorate
    end

    private

    def set_show
      @categories = Category.all.decorate
      @companies = Company.all.order(rating: :desc)
    end
  end
end
