# frozen_string_literal: true

class Price < ApplicationRecord
  validates_associated :user, :thing
  validates :amount, presence: true, numericality: true

  belongs_to :thing
  belongs_to :user
end
