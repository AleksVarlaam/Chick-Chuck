# frozen_string_literal: true

module Companies
  class ImagesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_company!
    before_action :set_company

    def index
      @images = @company.images
    end

    def upload_images
      respond_to do |format|
        if @company.update(images_params)
          format.turbo_stream do
            flash[:success] = t('flash.success.updated', model: t('company.gallery.title'))
            redirect_to request.referer
          end
        else
          format.turbo_stream do
            flash[:error] = t('flash.alert')
            redirect_to request.referer
          end
        end
      end
    end

    private

    def images_params
      params.require(:company).permit(images: [])
    end

    def set_company
      @company = current_company
    end
  end
end
