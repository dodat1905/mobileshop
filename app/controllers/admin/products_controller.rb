module Admin
  class ProductsController < Admin::BaseController
    attr_reader :product, :brand

    before_action :find_product, only: %i(show edit update destroy)
    before_action :find_brand, only: %i(new)

    def index
      @products = Product.desc.paginate page: params[:page], per_page: 10
    end

    def new
      @product =
        if brand.present?
          brand.products.new
        else
          @product = Product.new
        end
    end

    def create
      @product = Product.new product_params
      if product.save
        flash[:success] = t "product_created"
        redirect_to admin_products_url
      else
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      if product.update_attributes product_params
        flash[:success] = t "product_updated"
        redirect_to admin_products_url
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

    def find_brand
      @brand = Brand.find_by id: params[:brand_id]
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
end
