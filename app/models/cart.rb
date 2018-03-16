class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def current_cart? cart
    self == cart
  end

  def add_product product
    product_id = product.id
    line_item = line_items.find_by product_id: product_id

    if (current_item = line_item)
      current_item.quantity += 1
    else
      current_item = line_items.build product_id: product_id
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
