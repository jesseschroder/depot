module ProductConcern

  def all_products
    @products = Product.order(:title)
  end
end
