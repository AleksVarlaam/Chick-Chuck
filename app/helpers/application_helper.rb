# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  require 'image_helper'
  require 'navigation_helper'
  require 'meta_tags_helper'

  def prepend_flash
    turbo_stream.prepend 'flash_messages', partial: 'shared/flash_messages'
  end

  def current_locale_path(locale)
    url = request.original_url

    if url.include?('/sign_in')
      new_session_path(resource, locale:)
    elsif url.include?('/confirmation/new')
      new_confirmation_path(resource, locale:)
    elsif url.include?('/password/new')
      new_password_path(resource, locale:)
    else
      url_for(locale:)
    end
  end
end
