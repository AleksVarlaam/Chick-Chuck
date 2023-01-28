# frozen_string_literal: true

module ImageHelper
  def large(image)
    image.variant(resize_to_limit: [1024, 800], convert: 'webp')
  end

  def medium(image)
    image.variant(resize_to_limit: [600, 400], convert: 'webp')
  end

  def small(image)
    image.variant(resize_to_limit: [400, 200], convert: 'webp')
  end

  def avatar(image)
    image.variant(resize_to_limit: [300, 300], convert: 'webp')
  end
end
