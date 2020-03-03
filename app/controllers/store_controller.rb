class StoreController < ApplicationController
  include CurrentCart, ProductConcern
  skip_before_action :authorize
  before_action :set_cart
  before_action :all_products, only: :index

  def index
  end
end
