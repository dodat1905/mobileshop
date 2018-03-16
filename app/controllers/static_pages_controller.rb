class StaticPagesController < ApplicationController
  def index
    @brands = Brand.desc.all
    @products = Product.desc.paginate(page: params[:page], per_page: 12)
  end
end
