class ApplicationController < ActionController::Base
  before_action :authorize_web

  protected

  def authorize_web
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'Please log in'
    end
  end
end
