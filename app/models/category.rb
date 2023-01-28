# frozen_string_literal: true

class Category < ApplicationRecord
  validates :ru, :en, :he, presence: true
  has_many :things, dependent: :destroy
  has_many :products
end
