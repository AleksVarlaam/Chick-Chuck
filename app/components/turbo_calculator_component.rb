# frozen_string_literal: true

class TurboCalculatorComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(title:)
    @title = title
  end
end
