# frozen_string_literal: true

module Carrierwave
  class ImagesController < ApplicationController
    before_action :set_object

    def show
      @images = @object.images
    end

    def destroy
      respond_to do |format|
        if remove_image_at_index(params[:id].to_i) && @object.save!
          format.turbo_stream do
            flash[:success] = t('flash.success.destroyed', model: t('global.image'))
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

    def remove_image_at_index(index)
      remain_images = @object.images
      if index.zero? && @object.images.size == 1
        @object.remove_images!
      else
        deleted_image = remain_images.delete_at(index)
        deleted_image.try(:remove!)
        @object.images = remain_images
      end
    end

    def set_object
      @object = Product.find(params[:product_id]) if params[:product_id].present?
      @object = News.find(params[:news_id])       if params[:news_id].present?
      @object = Comment.find(params[:comment_id]) if params[:comment_id].present?
      @object = Message.find(params[:message_id]) if params[:message_id].present?
    end
  end
end
