class SupportCoupon
  attr_reader :order, :coupon

  def initialize args = {}
    @order = args[:order]
  end

  def line_items
    @line_items ||= order.line_items
  end

  def find_coupon
    @coupon = Coupon.find_by code: order.coupon_code
  end

  def show_sale_price
    order.line_items.inject(0) do |sum, price|
      sum + price.sale_price(coupon)
    end
  end

  def show_total_price
    order.line_items.inject(0) do |sum, price|
      sum + price.total_price
    end
  end
end
