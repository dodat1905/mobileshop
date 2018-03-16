class Product < ApplicationRecord
  belongs_to :brand
  has_many :comments, dependent: :destroy
  validates :brand_id, presence: true
  validates :description, presence: true
  scope :desc, ->{order created_at: :desc}
end
