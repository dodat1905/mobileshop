class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  scope :desc, ->{order created_at: :desc}

  def total_price
    product.price * quantity
  end
end
