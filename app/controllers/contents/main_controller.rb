# frozen_string_literal: true

module Contents
  class MainController < ApplicationController
    def index
      set_meta_tags(
        title: [params[:locale]&.capitalize, t('meta.home_page.title')],
        description: t('meta.home_page.desc')
      )
      @companies = Company.confirmed.take(3)
      @products = Product.where(published: true).decorate.take(6)
      @news = News.all.decorate.last(3)
      Statistic.first.update(main: Statistic.first.main + 1) unless user_signed_in?
    end

    def moving_preparation
      set_meta_tags(
        title: t('meta.moving_preparation.title'),
        description: t('meta.moving_preparation.desc')
      )
      Statistic.first.update(moving_preparation: Statistic.first.moving_preparation + 1) unless user_signed_in?
    end

    def sitemap
      @locales   = I18n.available_locales
      @users     = Company.confirmed
      @districts = District.ids
      @languages = Language.ids
      @services  = Service.ids
      @products  = Product.published
    end

    def robots; end
    
  end
end
