# frozen_string_literal: true

module ImageHelper
  def upload_image(imageable)
    @images = []
    params[:images]['file'].each do |image|
      @images << imageable.images.create!(file: image) if image.present?
    end
    @images.present?
  end

  def is_avatar?
    params[:avatar].present?
  end

  def image_path(image, object, avatar = nil)
    if    object.instance_of?(Product)
      carrierwave_image_path(id: image, product_id: object.id, avatar:)
    elsif object.instance_of?(Company)
      carrierwave_image_path(id: image, company_id: object.id, avatar:)
    elsif object.instance_of?(News)
      carrierwave_image_path(id: image, news_id: object.id, avatar:)
    elsif object.instance_of?(Comment)
      carrierwave_image_path(id: image, comment_id: object.id, avatar:)
    elsif object.instance_of?(Message)
      carrierwave_image_path(id: image, message_id: object.id, avatar:)
    end
  end
end
