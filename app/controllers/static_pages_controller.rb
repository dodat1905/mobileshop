class StaticPagesController < ApplicationController
  before_action :find_products, only: %i(home)

  def home
    @brands = Brand.desc.paginate page: params[:page]
  end

  private

  def find_products
    @products = Product.desc.paginate page: params[:page]
  end
end
