# frozen_string_literal: true

module ActiveStorage
  class AttachmentsController < ApplicationController
    before_action :set_attachment

    def destroy
      respond_to do |format|
        if (user_signed_in? || admin_signed_in?) && @attachment.purge_later
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: t('global.image')) }
        end
      end
    end

    private

    def set_attachment
      @attachment = ActiveStorage::Attachment.find(params[:id])
    end
  end
end
