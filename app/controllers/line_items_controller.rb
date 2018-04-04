class LineItemsController < ApplicationController
  before_action :find_item, only: %i(index destroy)
  before_action :find_product, only: :create

  def index
    return increase(item) if params[:method] == "increase"
    decrease item
    ajax
  end

  def create
    @line_item = cart.add_product product
    line_item.price = product.price
    ajax if line_item.save
  end

  def destroy
    @id = item.id
    item.destroy
    ajax
  end

  private

  attr_reader :line_item, :cart, :item, :product

  def ajax
    respond_to do |format|
      format.js
    end
  end

  def find_product
    @product = Product.find_by id: params[:product_id]

    return if product
    redirect_to root_path
    flash[:danger] = t "product_failed"
  end

  def find_item
    @item = LineItem.find_by id: params[:id]

    return if item
    redirect_to root_path
    flash[:danger] = t "not_exist"
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
