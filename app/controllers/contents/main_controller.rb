# frozen_string_literal: true

module Contents
  class MainController < ApplicationController
    def index
      set_meta_tags(
        title: [params[:locale]&.capitalize, t('meta.home_page.title')],
        description: t('meta.home_page.desc'),
        canonical: I18n.locale.to_s == params[:locale].to_s || I18n.default_locale.to_s ? root_url(locale: I18n.locale) : request.original_url,
      )
      @companies = Company.confirmed.take(3)
      @products = Product.where(published: true).decorate.take(6)
      @news = News.all.decorate.last(3)
      Statistic.first.update(main: Statistic.first.main + 1) unless user_signed_in?
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
    
    def favicon 
      respond_to do |format|
        format.png {  send_file 'app/assets/images/favicon.png', type: "image/png", disposition: 'inline', sizes: '120x120' }
      end
    end
    
  end
end
