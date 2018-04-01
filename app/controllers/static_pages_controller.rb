class StaticPagesController < ApplicationController
  before_action :page, only: %i(index)

  def index
    @brands = Brand.desc.all
    @products = Product.desc.paginate page: page, per_page: 9
  end

  private

  def page
    params[:page]
  end
end
