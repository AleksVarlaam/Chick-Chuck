module Contents
  class FeedbacksController < ApplicationController
    before_action :authenticate_user!, except: :index
    before_action :set_feedback
   
    def index
      set_meta_tags(
        title: t('review.reviews'),
        description: t('meta.about.desc')
      )
      
      @feedback ||= Feedback.new
    end 
    
    def create
      @feedback = Feedback.new(feedback_params)
      @feedback.user_id = current_user.id
      
      respond_to do |format|
        if @feedback.save
          # set_company_rating(@reviewable)
          format.turbo_stream { flash.now[:success] = t('flash.success.created', model: @feedback.model_name.human.to_s) }
        else
          format.html { redirect_to feedbacks_path, alert: t('flash.alert') }
        end
      end
    end
    
    def edit; end 
    
    def update
      respond_to do |format|
        if @feedback.update(feedback_params)
          # set_company_rating(@reviewable)
          format.html { redirect_to feedbacks_path, success:  t('flash.success.updated', model: @feedback.model_name.human.to_s) }
        else
          format.html { redirect_to feedbacks_path, alert: t('flash.alert') }
        end
      end
    end
    
    private
    
    def feedback_params
      params.require(:feedback).permit(:usability, :speed, :design, :quality, :informative, :problems, :title, :content)
    end
    
    def set_feedback
      @feedback = Feedback.find_by(user_id: current_user.id) if user_signed_in? 
    end
    
  end
end