class ProductApiController < ApiController
  include ProductConcern

  before_action :all_products, only: :index
  before_action :set_product, only: :show

  def index
  end

  def show
  end

end
