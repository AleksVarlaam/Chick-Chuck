module Contents
  class FeedbacksController < ApplicationController
    before_action :authenticate_user!, except: :index
   
    def index
      set_meta_tags(
        title: t('review.reviews'),
        description: t('meta.about.desc')
      )
      
      @feedback = Feedback.new
    end 
    
    def create

    end
    
    private
    
    def feedback_params
      params.require(:feedback).permit(:usability, :speed, :design, :quality, :informative, :problems, :title, :content)
    end
    
  end
end