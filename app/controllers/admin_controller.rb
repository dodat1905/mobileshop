class AdminController < ApplicationController
  def index
    @brand = Brand.desc.all
  end

  def brand
    @brands = Brand.desc.all
  end

  def product
    @products = Product.desc.paginate page: params[:page]
  end
end
