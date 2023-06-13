# frozen_string_literal: true

module Contents
  class CalculatorsController < ApplicationController
    include PricesHelper

    def show
      set_meta_tags( 
        title: t('meta.calculator.title'),
        description: t('meta.calculator.desc')
      )
      
      Statistic.first.update(calculator: Statistic.first.calculator + 1) unless user_signed_in?
      @categories = Category.all.decorate
      @companies = Company.confirmed
    end

    def company_calculator
      @company = Company.find_by_id(params[:company_id])
      @categories = Category.all.decorate
      
      set_meta_tags(
        title: [t('calculator.title'), @company.title],
        description: t('home_page.main_features.calculator_desc')
      )
    end

  end
end
