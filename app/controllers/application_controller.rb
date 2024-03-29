# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Internationalization
  include Devisable
  include Analytics

  add_flash_types :info, :danger, :warning, :success, :notice
end
