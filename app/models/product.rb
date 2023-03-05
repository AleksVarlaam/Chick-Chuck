# frozen_string_literal: true

class Product < ApplicationRecord
  include ImagesAttachments
  include Filterable
  validates_associated :user, :category, :thing
  validates :title, :condition, :delivery, :price, :images, presence: true

  belongs_to :user, foreign_key: :user_id
  belongs_to :category
  belongs_to :thing

  scope :filter_by_category_id, ->(category_id) { where category_id:, published: true }
  scope :filter_by_thing_id, ->(thing_id) { where thing_id:, published: true }

  def self.condition_select
    [
      [I18n.t('product.condition.below_average'), 1], [I18n.t('product.condition.average'), 2],
      [I18n.t('product.condition.above_average'), 3], [I18n.t('product.condition.like_new'), 4]
    ]
  end

  def self.delivery_select
    [
      [I18n.t('global.da'), 1], [I18n.t('product.delivery.pickup'), 2]
    ]
  end
end
