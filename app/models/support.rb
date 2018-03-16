class Support
  def users
    @users ||= User.desc.limit(5)
  end

  def brands
    @brands ||= Brand.all
  end

  def products
    @products ||= Product.all
  end
end
