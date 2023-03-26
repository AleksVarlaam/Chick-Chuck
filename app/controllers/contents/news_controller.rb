# frozen_string_literal: true

module Contents
  class NewsController < ApplicationController
    before_action :set_show, only: :show

    def index
      Statistic.first.update(news: Statistic.first.news + 1) unless user_signed_in?
      @pagy, @news = pagy(News.where(published: true), items: 8, fragment: '#news')
      @news = @news.decorate
    end

    def show; end

    private

    def set_show
      @new = News.find_by_id(params[:id]).decorate
      @news = News.all.decorate
      @commentable, @ratingable = @new
      @comment = Comment.new
      @pagy, @comments = pagy(@new.comments.where(commentable_type: News.name).newest, items: 10,
                                                                                       fragment: '#comments')

      return if current_admin

      @new.update(views: @new.views + 1)
    end
  end
end
