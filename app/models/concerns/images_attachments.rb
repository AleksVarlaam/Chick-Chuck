# frozen_string_literal: true

module ImagesAttachments
  extend ActiveSupport::Concern

  included do
    has_many_attached :images, dependent: :purge do |attachable|
      attachable.variant(:medium, resize_to_limit: [600, 600])
      attachable.variant(:large,  resize_to_limit: [1200, 1200])
    end

    validates :images, file_size: { less_than_or_equal_to: 10.megabytes },
                       file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

    def append_images=(attachables)
      images.attach(attachables)
    end
  end
end
