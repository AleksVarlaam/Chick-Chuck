# frozen_string_literal: true

module Clients
  class ProfilesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_client!
    before_action :set_profile, only: %i[edit update]

    def edit; end

    def update
      respond_to do |format|
        if @profile.update(set_profile_params)
          format.turbo_stream { flash.now[:success] = t('flash.success.updated', model: t('flash.account')) }
        else
          format.html { render :edit, alert: 'Something went wrong' }
        end
      end
    end

    private

    def set_profile
      @profile = current_client
    end

    def set_profile_params
      params.require(:client).permit(:first_name, :last_name, :avatar, :gender, :birthday, :city_id, :remove_avatar,
                                     :additional_phone, :whatsapp, :telegram, :facebook)
    end
  end
end
