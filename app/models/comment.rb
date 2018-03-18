class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :description, presence: true, length: {maximum: 150}
  scope :desc, ->{order created_at: :desc}
end
