# frozen_string_literal: true

module Contents
  class MainController < ApplicationController
    def index
      trucks = Truck.published
      @top_trucks = trucks.take(3)
      @pagy_a, @trucks = pagy_array(trucks.drop(3), items: 4, fragment: '#latest_trucks_title')
      @products = Product.all.decorate.take(6)
      @news = News.all.decorate.last(3)
    end

    def moving_preparation; end
  end
end
