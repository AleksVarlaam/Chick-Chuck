# frozen_string_literal: true

class FeedbackDecorator < ApplicationDecorator
  delegate_all

  def created_at
    l feedback.created_at, format: :date
  end

  def updated_at
    l feedback.updated_at, format: :date
  end
end
