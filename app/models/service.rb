# frozen_string_literal: true

class Service < ApplicationRecord
  validates :ru, :en, :he, :uk, presence: true

  has_and_belongs_to_many :users, optional: true
end
