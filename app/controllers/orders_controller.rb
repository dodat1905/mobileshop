class OrdersController < ApplicationController
  before_action :current_cart, only: %i(new create)
  before_action :find_order, only: %i(show update)
  before_action :find_line_item, only: %i(show edit)
  before_action :create_order, only: :create

  def new
    cart.line_items.empty? ? redirect_to(root_path) : @order = Order.new
  end

  def create
    order.update_attributes product_code: generate
    order.add_line_items_from_cart cart

    if order.save
      create_success
      create_notification order
    else
      render :new
    end
  end

  def show
    @line_items = order.line_items
    user_signed_in? ? current_order : redirect_to(root_path)
  end

  def edit
    @order = Order.find_by id: params[:id], product_code: params[:product_code]

    if order
      @line_items = order.line_items
    else
      redirect_to root_path
    end
  end

  def update
    order.update_attributes order_status: "cancelled"
    redirect_to order
  end

  private

  attr_reader :cart, :order, :line_items, :line_item, :generate

  def current_order
    return if current_user.orders.find_by id: params[:id]
    redirect_to root_path
  end

  def find_line_item
    @line_item = LineItem.find_by order_id: params[:id]

    return if line_item
    flash[:warning] = t "failed_line_item"
    redirect_to root_path
  end

  def find_order
    @order = Order.find_by id: params[:id]

    return if order
    flash[:warning] = t "failed_order"
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit :name, :email, :address, :phone
  end

  def create_order
    @order = Order.new order_params
    order.user = current_user if current_user
    @generate = (0...8).map{(Settings.generate + rand(Settings.rand)).chr}.join
  end

  def create_success
    Cart.destroy session[:cart_id]
    session[:card_id] = nil
    redirect_to root_url
    flash[:success] = current_user ? t("thank") : t("check")
  end

  def create_notification order
    ProductCodeMailer.product_code(order).deliver_now if current_user.blank?
    Notification.create content: "new_order", order_url: order_path(order)
    ActionCable.server.broadcast "notification_channel", message: "success"
  end
end
