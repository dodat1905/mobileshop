class ProductsController < ApplicationController
  attr_reader :product

  before_action :find_product, only: %i(show)
  before_action :all_brands, only: %i(index show)
  before_action :find_products, only: %i(show)

  def index
    @products = Product.desc.paginate page: params[:page]
  end

  def show; end

  private

  def all_brands
    @brands = Brand.desc.all
  end

  def find_products
    @products = Product.desc.paginate page: params[:page]
  end

  def find_product
    @product = Product.find_by id: params[:id]

    return if product
    flash[:success] = t "failed_product"
    redirect_to root_path
  end
end
