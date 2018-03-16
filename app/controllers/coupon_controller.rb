class CouponController < ApplicationController
  attr_reader :coupon
  before_action :logged_in_user, only: %i(new edit update destroy)

  def index
    @coupons = Product.desc.paginate page: params[:page]
  end

  def edit
    @coupon = Product.find_by id: params[:id]
  end

  def update
    @coupon = Product.find_by id: params[:id]
    if coupon.update_attributes coupon_params
      flash[:success] = t "product_updated"
      redirect_to_admin
    else
      render :edit
    end
  end

  def destroy
    @coupon = Product.find_by id: params[:id]
    coupon.destroy
    flash[:success] = t "coupon_deleted"
    redirect_to request.referer || root_url
  end

  private

  def redirect_to_admin
    if current_user.admin?
      redirect_to admin_products_url
    else
      redirect_to product
    end
  end

  def coupon_params
    params.require(:product).permit :available, :name,
      :description, :image, :price, :brand_id, :coupon, :count, :percent
  end
end
