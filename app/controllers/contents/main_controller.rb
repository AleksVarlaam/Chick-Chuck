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
      # @news = News.all.decorate.last(3)
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
        format.png do
          send_file 'app/assets/images/favicon.png', type: 'image/png', disposition: 'inline', sizes: '120x120'
        end
      end
    end
  end
end
