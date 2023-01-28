# frozen_string_literal: true

class Language < ApplicationRecord
  validates :title, presence: true

  has_and_belongs_to_many :companies, class_name: 'Company', foreign_key: :user_id, optional: true
end
