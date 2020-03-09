module ProductConcern

  def set_product
    @product = Product.find(params[:id])
  end

  def all_products
    @products = Product.order(:title)
  end
end
