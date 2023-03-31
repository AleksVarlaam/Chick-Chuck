# frozen_string_literal: true

module Contents
  class StatisticsController < ApplicationController
    def show
      Statistic.first.update(about: Statistic.first.about + 1) unless user_signed_in?
      @statistic = @commentable = Statistic.first
      @clients = Client.count
      @companies = Company.count
      @trucks = Truck.where(published: true).count
      @products = Product.where(published: true).count
      @reviews = Review.count + Comment.count
      @comments = @statistic.comments
      @comment = Comment.new
      @pagy, @comments = pagy(@statistic.comments.where(commentable_type: Statistic.name).newest, items: 10,
                                                                                                  fragment: '#comments')
    end
  end
end
