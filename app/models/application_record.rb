# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :newest, -> { order('created_at DESC') }
  scope :latest, -> { order('created_at ASC') }
end
