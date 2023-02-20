class MailersController < ApplicationController
  
  def create
    subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      unless Subscriber.find_by(email: subscriber_params[:email]).present? || User.where(email: subscriber_params[:email]).present?
        format.turbo_stream { flash.now[:success] = t('mailers.flash.success')} if subscriber.save
      else
        format.turbo_stream { flash.now[:alert] = t('mailers.flash.info')}        
      end
    end
  end
  
  private 
  
  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
  
end