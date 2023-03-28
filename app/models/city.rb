class City < ApplicationRecord
  validates :ru, :en, :he, :uk, presence: true
  validates_associated :district
  
  belongs_to :district
end
