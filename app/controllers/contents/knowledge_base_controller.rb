# frozen_string_literal: true

module Contents
  class KnowledgeBaseController < ApplicationController
    def about
      set_meta_tags(
        title: t('meta.about.title'),
        description: t('meta.about.desc')
      )

      @clients = Client.count
      @companies = Company.confirmed.count
      @products = Product.where(published: true).count
      @reviews = Review.count + Comment.count
    end
    
    def feedback
      set_meta_tags(
        title: t('review.reviews'),
        description: t('meta.about.desc')
      )
      
      @feedback = Review.new
    end
  end
end
