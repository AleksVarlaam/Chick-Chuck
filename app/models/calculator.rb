# frozen_string_literal: true

class Calculator < ApplicationRecord
  validates_associated :company
  validates :distance, :floor_down, :floor_down_elevator, :floor_up, :floor_up_elevator, numericality: true,
                                                                                         uniqueness: true

  belongs_to :company, foreign_key: :user_id
end
