class Subscriber < ApplicationRecord
  validates :email, uniqueness: true, presence: true
end
