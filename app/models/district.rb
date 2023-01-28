# frozen_string_literal: true

class District < ApplicationRecord
  validates :ru, :en, :he, presence: true
  has_many :trucks

  has_and_belongs_to_many :users, optional: true
  has_and_belongs_to_many :trucks, optional: true
end
