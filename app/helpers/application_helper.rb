# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  require 'image_helper'
  require 'navigation_helper'
  require 'meta_tags_helper'

  def prepend_flash
    turbo_stream.prepend 'flash_messages', partial: 'shared/flash_messages'
  end
end
