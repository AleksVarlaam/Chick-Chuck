# frozen_string_literal: true

module Contents
  class AboutController < ApplicationController
    def index
      set_meta_tags(
        title: t('meta.about.title'),
        description: t('meta.about.desc'),
        alternate: {
          "x-default" => about_url(locale: nil),
          "en" => about_url(locale: :en),
          "ru" => about_url(locale: :ru),
          "uk" => about_url(locale: :uk),
        }
      )

      @clients = Client.count
      @companies = Company.confirmed.count
      @products = Product.where(published: true).count
      @reviews = Review.count + Comment.count
    end
    
  end
end
