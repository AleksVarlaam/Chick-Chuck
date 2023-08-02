# frozen_string_literal: true

module Users
  class MailersController < ApplicationController
    def create
      subscriber = Subscriber.new(subscriber_params)

      respond_to do |format|
        if Subscriber.find_by(email: subscriber_params[:email]).present? || User.where(email: subscriber_params[:email]).present?
          format.turbo_stream { flash.now[:alert] = t('flash.mailers.info') }
        elsif subscriber.save
          format.turbo_stream { flash.now[:success] = t('flash.mailers.success') }
        end
      end
    end

    private

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
  end
end
