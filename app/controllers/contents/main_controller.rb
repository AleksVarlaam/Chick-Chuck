# frozen_string_literal: true

module Contents
  class MainController < ApplicationController
    def index
      trucks = Truck.published
      @top_trucks = trucks.take(3)
      @pagy_a, @trucks = pagy_array(trucks.drop(3), items: 4, fragment: '#latest_trucks_title')
      @products = Product.where(published: true).decorate.take(6)
      @news = News.all.decorate.last(3)
      Statistic.first.update(main: Statistic.first.main + 1) unless user_signed_in?
    end

    def moving_preparation
       Statistic.first.update(moving_preparation: Statistic.first.mpving_preparation + 1) unless user_signed_in?
    end
    
    def about
      Statistic.first.update(about: Statistic.first.about + 1) unless user_signed_in?
      @statistic = @commentable = Statistic.first
      @clients = Client.all.count
      @companies = Company.all.count
      @trucks = Truck.where(published: true).count
      @products = Product.where(published: true).count
      @reviews = Review.all.count + Comment.all.count
      @comments = @statistic.comments
      @comment = Comment.new
      @pagy, @comments = pagy(@statistic.comments.where(commentable_type: Statistic.name).newest, items: 10,
                                                                                          fragment: '#comments')
    end
    
  end
end
