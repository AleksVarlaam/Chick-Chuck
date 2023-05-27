# frozen_string_literal: true

class Truck < ApplicationRecord
  include Filterable
  validates :districts, presence: true
  validates :length, allow_blank: false, numericality: { in: 1..20 }
  validates :load_capacity, allow_blank: false, numericality: { in: 0.1..20 }
  validates :height, :width, allow_blank: false, numericality: { in: 1..5 }
  validates :images, :body_type, :assembly, :packing, presence: true

  mount_uploaders :images, ImageUploader
  belongs_to :company, class_name: 'Company', foreign_key: :user_id

  has_and_belongs_to_many :districts, optional: true

  default_scope { order(created_at: :desc) }
  scope :filter_by_district_id, lambda { |district_id|
                                  joins(:districts).where 'districts.id' => district_id, published: true
                                }
  scope :filter_by_body_type, ->(body_type) { where body_type:, published: true }
  scope :published, -> { where published: true }

  # Constants:
  def self.body_type_select
    [
      [I18n.t('truck.body_type.tent'), 1], [I18n.t('truck.body_type.isometric'), 2], [I18n.t('truck.body_type.side_body'), 3],
      [I18n.t('truck.body_type.trailer_tent'), 4], [I18n.t('truck.body_type.trailer_isometric'), 5], [I18n.t('truck.body_type.trailer_side_body'), 6]
    ]
  end

  def self.assembly_select
    [
      [I18n.t('global.da'),
       1], [I18n.t('global.net'), 2], [I18n.t('truck.assembly.only_assembly'), 3], [I18n.t('truck.assembly.only_disassembly'), 4]
    ]
  end

  def self.packing_select
    [
      [I18n.t('global.da'), 1], [I18n.t('global.net'), 2]
    ]
  end
end
