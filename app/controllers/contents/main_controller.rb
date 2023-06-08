# frozen_string_literal: true

module Contents
  class MainController < ApplicationController
    def index
      @companies = Company.confirmed.take(3)
      @products = Product.where(published: true).decorate.take(6)
      @news = News.all.decorate.last(3)
      Statistic.first.update(main: Statistic.first.main + 1) unless user_signed_in?
    end

    def moving_preparation
      Statistic.first.update(moving_preparation: Statistic.first.moving_preparation + 1) unless user_signed_in?
    end
  end
end
