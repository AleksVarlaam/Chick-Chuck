# frozen_string_literal: true

class Company < User
  validates :title, uniqueness: true, presence: true
  validates :districts, :languages, presence: true
  validates :description, length: { maximum: 500 }
  validates :rating, numericality: { in: 0..10 }

  has_and_belongs_to_many :districts, class_name: 'District', foreign_key: :user_id
  has_and_belongs_to_many :languages, class_name: 'Language', foreign_key: :user_id
  has_and_belongs_to_many :rooms, class_name: 'Room', foreign_key: :user_id, dependent: :destroy
  has_one  :calculator, class_name: 'Calculator', dependent: :destroy, foreign_key: :user_id
  has_many :trucks, class_name: 'Truck', dependent: :destroy, foreign_key: :user_id
  has_many :products, class_name: 'Product', dependent: :destroy, foreign_key: :user_id
  has_many :prices, class_name: 'Price', dependent: :destroy, foreign_key: :user_id

  def avatar_attachment_path
    avatar.attached? ? avatar.variant(:avatar) : 'icons/laavor/laavor_favicon.png'
  end

  def user_name
    title
  end
end
