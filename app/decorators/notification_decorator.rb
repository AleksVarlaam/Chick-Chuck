# frozen_string_literal: true

class NotificationDecorator < ApplicationDecorator
  delegate_all

  def created_at
    h.content_tag(:span, (l notification.created_at, format: :short), class: 'text-xs ml-1 text-gray-400')
  end
end
