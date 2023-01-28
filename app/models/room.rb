# frozen_string_literal: true

class Room < ApplicationRecord
  has_and_belongs_to_many :users

  has_many :messages, class_name: 'Message', dependent: :destroy

  before_create { self.title = SecureRandom.hex(5) }

  def recipient(current_user)
    users.where.not(id: current_user)[0]
  end
end
