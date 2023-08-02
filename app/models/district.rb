# frozen_string_literal: true

class District < ApplicationRecord
  validates :ru, :en, :he, :uk, presence: true
  has_many :products
  has_many :cities, dependent: :destroy

  has_and_belongs_to_many :users, optional: true
end
