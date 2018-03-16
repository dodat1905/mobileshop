class BrandsController < ApplicationController
  attr_reader :brand

  before_action :find_brand, only: %i(edit show update destroy)

  def index
    @brands = Brand.paginate page: params[:page]
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new brand_params
    if brand.save
      notice_redirect
    else
      render :new
    end
  end

  def show
    @brands = Brand.all
    @brand = Brand.find_by id: params[:id]
  end

  def edit; end

  def update
    if brand.update_attributes brand_params
      flash[:success] = t "brand_updated"
      redirect_to brand
    else
      render :edit
    end
  end

  def destroy
    brand.destroy
    flash[:success] = t "brand_deleted"
    redirect_to brands_url
  end

  private

  def notice_redirect
    flash[:info] = t "created_brand"
    redirect_to brands_url
  end

  def brand_params
    params.require(:brand).permit :name
  end

  def find_brand
    @brand = Brand.find_by id: params[:id]

    return if brand
    flash[:success] = t "failed_brand"
    redirect_to root_path
  end
end
