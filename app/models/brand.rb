class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  scope :desc, ->{order created_at: :desc}

end
