# frozen_string_literal: true

class Product < ApplicationRecord
  include ImagesAttachments
  include Filterable
  validates_associated :category, :thing, :district, :city
  validates  :title, :condition, :delivery, :price, :images, presence: true

  belongs_to :user, foreign_key: :user_id
  belongs_to :category
  belongs_to :thing
  belongs_to :district
  belongs_to :city

  scope :filter_by_category_id, ->(category_id) { where category_id:, published: true }
  scope :filter_by_thing_id, ->(thing_id) { where thing_id:, published: true }
  scope :filter_by_district_id, ->(district_id) { where district_id:, published: true }
  scope :filter_by_city_id, ->(city_id) { where city_id:, published: true }

  def self.condition_select
    [
      [I18n.t('product.condition.any'), 0],
      [I18n.t('product.condition.second_hand'), 1], [I18n.t('product.condition.new'), 2]
    ]
  end

  def self.delivery_select
    delivery_select = [
      [I18n.t('product.delivery.pickup'), 0]
    ]
    District.all.decorate.each do |district|
      delivery_select << [district.title, district.id]
    end
    delivery_select
  end
end
