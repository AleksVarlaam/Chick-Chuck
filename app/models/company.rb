# frozen_string_literal: true

class Company < User
  include CompanyDecorate
  validates :title, uniqueness: true, presence: true
  validates :districts, :languages, presence: true
  validates :description, length: { maximum: 1000 }
  validates :rating, numericality: { in: 0..5 }

  has_rich_text :description
  mount_uploaders :images, ImageUploader
  has_and_belongs_to_many :districts, class_name: 'District', foreign_key: :user_id
  has_and_belongs_to_many :languages, class_name: 'Language', foreign_key: :user_id
  has_and_belongs_to_many :services,  class_name: 'Service',  foreign_key: :user_id
  has_and_belongs_to_many :rooms,     class_name: 'Room',     foreign_key: :user_id, dependent: :destroy
  has_one  :calculator, class_name: 'Calculator', dependent: :destroy, foreign_key: :user_id
  has_many :products,   class_name: 'Product', dependent: :destroy, foreign_key: :user_id
  has_many :prices,     class_name: 'Price', dependent: :destroy, foreign_key: :user_id
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
  scope :filter_by_service_id, lambda { |service_id|
                                  joins(:services).where('services.id' => service_id).uniq if service_id.count > 1
                                }
                                
  after_destroy :clear_favorites
  
  private 
  
  def clear_favorites
    Favorite.where(favorited_type: 'Company', favorited_id: self.id).destroy_all
  end

end
