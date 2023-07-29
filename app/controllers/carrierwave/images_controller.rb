# frozen_string_literal: true

module Carrierwave
  class ImagesController < ApplicationController
    before_action :set_object
    
    def upload_images
      return unless params[:images].present?
      @images = []
      params[:images]['file'].each do |image|
        @images << @object.images.create!(file: image) if image.present?
      end
      respond_to do |format|
        format.turbo_stream do
          flash.now[:success] =
            t('flash.success.updated', model: "#{@object.model_name.human} #{@object.title.downcase}")
        end
      end
    end
    

    def show
      if params[:avatar].present?
        @images = [@object.avatar]
      else
        @images = @object.images
        start_index = params[:id].to_i
        @images = @images.select { |img|
          img.id >= start_index
        } + @images.select do |img|
          img.id < start_index
        end
      end
    end

    def destroy
      @image = Image.find(params[:id])
      respond_to do |format|
        if @image.destroy
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
    
    def images_params
      params.require(:imageable).permit(images_attributes: [:id, :file])
    end

    def set_object
      @object = Product.find(params[:product_id]) if params[:product_id].present?
      @object = Company.find(params[:company_id]) if params[:company_id].present?
      @object = Comment.find(params[:comment_id]) if params[:comment_id].present?
      @object = Message.find(params[:message_id]) if params[:message_id].present?
      @object = News.find(params[:news_id])       if params[:news_id].present?
    end
  end
end
