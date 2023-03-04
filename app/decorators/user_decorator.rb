# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  def created_at
    "#{User.human_attribute_name('created_at')}: #{l user.created_at, format: :date}"
  end
end
