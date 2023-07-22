# frozen_string_literal: true

module ImageHelper
  def image_path(index, object, avatar = nil)
    if    object.instance_of?(Product)
      carrierwave_image_path(id: index, product_id: object.id, avatar:)
    elsif object.instance_of?(Company)
      carrierwave_image_path(id: index, company_id: object.id, avatar:)
    elsif object.instance_of?(News)
      carrierwave_image_path(id: index, news_id: object.id, avatar:)
    elsif object.instance_of?(Comment)
      carrierwave_image_path(id: index, comment_id: object.id, avatar:)
    elsif object.instance_of?(Message)
      carrierwave_image_path(id: index, message_id: object.id, avatar:)
    end
  end
end
