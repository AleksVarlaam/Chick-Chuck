# frozen_string_literal: true

class Statistic < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy, class_name: 'Comment'
  has_many :comments, as: :object,      dependent: :destroy, class_name: 'Comment'
end
