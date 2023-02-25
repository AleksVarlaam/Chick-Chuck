# frozen_string_literal: true

class Thing < ApplicationRecord
  include Filterable
  validates :ru, :en, :he, presence: true, uniqueness: true
  validates_associated :category

  belongs_to :category

  has_many   :prices, dependent: :destroy
  has_many   :products
end
