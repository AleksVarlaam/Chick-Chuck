module Contents
  class FeedbacksController < ApplicationController
    before_action :authenticate_user!, except: :index
   
    def index
      set_meta_tags(
        title: t('review.reviews'),
        description: t('meta.about.desc')
      )
      
      @feedback = Review.new
    end 
    
  end
end