# frozen_string_literal: true

module ImagesAttachments
  extend ActiveSupport::Concern

  included do
    has_many_attached :images, dependent: :purge

    validates :images, file_size: { less_than_or_equal_to: 10.megabytes },
                       file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

    def append_images=(attachables)
      images.attach(attachables)
    end
  end
end
