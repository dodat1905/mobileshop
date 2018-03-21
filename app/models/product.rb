class Product < ApplicationRecord
  belongs_to :brand
  has_many :comments, dependent: :destroy
  has_many :line_items, dependent: :destroy

  validates :brand_id, presence: true
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :coupon, numericality: {only_integer: true}
  validates :count, numericality: {only_integer: true}
  validates :percent, numericality: {only_integer: true}
  validates :price, presence: true, numericality: {only_integer: true}
  validates :description, presence: true
  scope :desc, ->{order created_at: :desc}
end
