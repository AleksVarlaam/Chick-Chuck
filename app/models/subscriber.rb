# frozen_string_literal: true

class Subscriber < ApplicationRecord
  validates :email, uniqueness: true, presence: true
end
