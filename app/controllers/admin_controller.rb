class AdminController < ApplicationController

  before_action :admin_user

  def index
    @brand = Brand.desc.all
  end

  def brand
    @brands = Brand.desc.all
  end

  def product
    @products = Product.desc.paginate page: params[:page]
  end

  private

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
