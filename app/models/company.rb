# frozen_string_literal: true

class Company < User
  validates :title, uniqueness: true, presence: true
  validates :districts, :languages, presence: true
  validates :description, length: { maximum: 1000 }
  validates :rating, numericality: { in: 0..5 }

  has_rich_text :description
  has_and_belongs_to_many :districts, class_name: 'District', foreign_key: :user_id
  has_and_belongs_to_many :languages, class_name: 'Language', foreign_key: :user_id
  has_and_belongs_to_many :services,  class_name: 'Service',  foreign_key: :user_id
  has_and_belongs_to_many :rooms,     class_name: 'Room',     foreign_key: :user_id, dependent: :destroy
  has_one  :calculator, class_name: 'Calculator', dependent: :destroy, foreign_key: :user_id
  has_many :products, class_name: 'Product', dependent: :destroy, foreign_key: :user_id
  has_many :prices, class_name: 'Price', dependent: :destroy, foreign_key: :user_id
  has_many :reviews,  as: :reviewable,  dependent: :destroy, class_name: 'Review'
  has_many :comments, as: :commentable, dependent: :destroy, class_name: 'Comment', foreign_key: :user_id
  has_many :comments, as: :object,      dependent: :destroy, class_name: 'Comment', foreign_key: :user_id

  # Scopes
  scope :confirmed, -> { where.not(confirmed_at: nil).order(rating: :desc) }
  scope :filter_by_district_id, lambda { |district_id|
                                  joins(:districts).where 'districts.id' => district_id
                                }
  scope :filter_by_language_id, lambda { |language_id|
                                  joins(:languages).where 'languages.id' => language_id
                                }
  scope :filter_by_service_ids, lambda { |service_ids|
                                  joins(:services).where('services.id' => service_ids).uniq if service_ids.count > 1
                                }

  def avatar_attachment_path
    avatar.present? ? avatar.avatar.url : 'icons/chick-chuck/laavor_favicon.png'
  end

  def user_name
    title
  end
end
