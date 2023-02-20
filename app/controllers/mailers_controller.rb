class MailersController < ApplicationController
  before_action :check_email_dublicate, only: :create
  
  def create
    subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if subscriber.save
        format.turbo_stream { flash.now[:success] = 'Subscribe success!'}
      else
        if Subscriber.find_by(email: subscriber_params[:email]).present?
          format.turbo_stream { flash.now[:info] = 'This email already exists!'}
        else
          format.turbo_stream { flash.now[:alert] = "This field can't be blunk!"}
        end
      end
    end
  end
  
  private 
  
  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
  
  def check_email_dublicate
    
  end
end