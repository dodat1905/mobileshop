module Admin
  class OrdersController < Admin::BaseController
    attr_reader :order, :orders

    before_action :find_order, only: %i(show edit update destroy)

    def index
      @orders = Order.desc.paginate page: params[:page], per_page: 10
    end

    def show
      @line_items = order.line_items.desc.paginate(page: params[:page],
        per_page: 10)
      @line_item = LineItem.find_by order_id: params[:id]
    end

    def edit; end

    def update
      @order = Order.find_by id: params[:id]
      if order.update_attributes order_params
        flash[:success] = t "order_updated"
        redirect_to admin_orders_url
      else
        render :edit
      end
    end

    def destroy
      order.destroy
      flash[:success] = t "order_deleted"
      redirect_to admin_orders_url
    end

    private

    def order_params
      params.require(:order).permit :name,
        :email, :address, :phone, :order_status
    end

    def find_order
      @order = Order.find_by id: params[:id]

      return if order
      flash[:success] = t "failed_order"
      redirect_to root_path
    end
  end
end
