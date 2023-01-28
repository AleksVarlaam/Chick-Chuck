# frozen_string_literal: true

class TurboProfileComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(title:)
    @title = title
  end
end
