# frozen_string_literal: true

module ImageHelper
  
  def image_destroy_path(index, object)
    if    object.instance_of?(Product)
      carrierwave_image_path(id: index, product_id: object.id)
    elsif object.instance_of?(Truck)
      carrierwave_image_path(id: index, truck_id: object.id)
    elsif object.instance_of?(News)
      carrierwave_image_path(id: index, news_id: object.id)
    elsif object.instance_of?(Comment)
      carrierwave_image_path(id: index, comment_id: object.id)
    elsif object.instance_of?(Message)
      carrierwave_image_path(id: index, message_id: object.id)
    end
  end
end
