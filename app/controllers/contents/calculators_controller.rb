# frozen_string_literal: true

module Contents
  class CalculatorsController < ApplicationController
    include PricesHelper
    before_action :set_show, only: %i[show]

    def show; end

    def modal
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
