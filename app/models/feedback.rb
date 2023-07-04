class Feedback < ApplicationRecord
  validates :usability, :speed, :design, :quality, numericality: { in: 0..5 }
  belongs_to :user
end
