# frozen_string_literal: true

module Contents
  class NewsController < ApplicationController
    before_action :set_show, only: :show

    def index
      set_meta_tags(
        title: t('pages.news'),
        alternate: {
          "x-default" => news_url(locale: nil),
          "en" => news_url(locale: :en),
          "ru" => news_url(locale: :ru),
          "ua" => news_url(locale: :ua),
        }
      )

      @pagy, @news = pagy(News.where(published: true), items: 8, fragment: '#news')
      @news = @news.decorate
    end

    def show; end

    private

    def set_show
      set_meta_tags(
        title: t('pages.news')
      )
      
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
