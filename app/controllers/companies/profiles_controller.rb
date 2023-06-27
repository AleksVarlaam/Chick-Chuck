# frozen_string_literal: true

module Companies
  class ProfilesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_company!
    before_action :set_company, only: %i[profile profile_update company_info company_info_update]

    def profile; end

    def profile_update
      respond_to do |format|
        if @company.update set_profile_params
          format.turbo_stream { flash.now[:success] = t('flash.success.updated', model: t('flash.account')) }
        else
          format.html { render :profile, status: :unprocessable_entity }
        end
      end
    end

    def company_info; end

    def company_info_update
      respond_to do |format|
        if @company.update set_company_info_params
          format.turbo_stream { flash.now[:success] = t('flash.success.updated', model: t('flash.account')) }
        else
          format.html { render :company_info, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_company
      @company = current_company
    end

    def set_profile_params
      params.require(:company).permit(
        :first_name, :last_name, :gender, :birthday, :city_id
      )
    end

    def set_company_info_params
      params.require(:company).permit(
        :avatar, :additional_phone, :whatsapp, :telegram, :facebook, :title, :website, :description, :remove_avatar, {
          district_ids: [], language_ids: [], service_ids: []
        }
      )
    end
  end
end
