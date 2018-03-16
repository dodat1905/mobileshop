class ProductsController < ApplicationController
  attr_reader :product

  before_action :find_product, only: %i(edit show update destroy)
  before_action :all_brands, only: %i(new index show)
  before_action :find_products, only: %i(show)

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if product.save
      flash[:success] = t "product_created"
      redirect_to_admin
    else
      render :new
    end
  end

  def index
    @products = Product.desc.paginate page: params[:page]
  end

  def show; end

  def edit; end

  def update
    if product.update_attributes product_params
      flash[:success] = t "product_updated"
      redirect_to_admin
    else
      render :edit
    end
  end

  def destroy
    product.destroy
    flash[:success] = t "product_deleted"
    redirect_to request.referer || root_url
  end

  private

  def redirect_to_admin
    if current_user.try(:admin?)
      redirect_to admin_products_url
    else
      redirect_to product
    end
  end

  def all_brands
    @brands = Brand.desc.all
  end

  def find_products
    @products = Product.desc.paginate page: params[:page]
  end

  def product_params
    params.require(:product).permit :available, :name,
      :description, :image, :price, :brand_id, :coupon, :count, :percent
  end

  def find_product
    @product = Product.find_by id: params[:id]

    return if product
    flash[:success] = t "failed_product"
    redirect_to root_path
  end
end
