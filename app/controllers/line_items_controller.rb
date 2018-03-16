class LineItemsController < ApplicationController
  attr_reader :line_item, :cart, :item, :product

  before_action :current_cart, only: :create
  before_action :find_item, only: :destroy
  before_action :find_product, only: :create

  def index
    item = LineItem.find_by id: params[:id]

    return increase(item) if params[:method] == "increase"
    decrease item
  end

  def create
    @line_item = cart.add_product product
    line_item.price = product.price
    return item_saved if line_item.save
    flash[:danger] = t ".error"
    redirect_to root_url
  end

  def destroy
    item.destroy
    redirect_to root_url
    flash[:notice] = t ".removed"
  end

  private

  def find_product
    @product = Product.find_by id: params[:product_id]
  end

  def find_item
    @item = LineItem.find_by id: params[:id]

    return if item
    root_url root_url
    flash[:danger] = t ".not_exist"
  end

  def item_saved
    flash[:notice] = t ".added"
    redirect_to cart
  end

  def increase item
    quantity = item.quantity + 1
    item.update_attributes quantity: quantity
    redirect_to cart
  end

  def decrease item
    quantity = item.quantity - 1

    return if quantity.zero?
    item.update_attributes quantity: quantity
    redirect_to cart
  end
end
