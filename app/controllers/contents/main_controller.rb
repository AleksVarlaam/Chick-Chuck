# frozen_string_literal: true

module Contents
  class MainController < ApplicationController
    def index
      trucks = Truck.published.decorate
      @top_trucks = trucks.take(3)
      @trucks = trucks.drop(3).take(6) if trucks.count > 3
      @products = Product.where(published: true).decorate.take(6)
      @news = News.all.decorate.last(3)
      Statistic.first.update(main: Statistic.first.main + 1) unless user_signed_in?
    end

    def moving_preparation
      Statistic.first.update(moving_preparation: Statistic.first.moving_preparation + 1) unless user_signed_in?
    end
  end
end
