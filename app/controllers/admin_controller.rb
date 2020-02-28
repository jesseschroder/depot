class AdminController < ApplicationController
  def index
    @total_orders = 10 # Order.count
    @user = User.find(session[:user_id])
  end
end
