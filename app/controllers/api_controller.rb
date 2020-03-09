class ApiController < ActionController::Base
  before_action :authenticate_with_basic_auth

  private

  ## Find credentials by name, render error unless the credentials are valid

  def authenticate_with_basic_auth
    name, token = ActionController::HttpAuthentication::Basic.user_name_and_password(request)
    @api_client = ApiClient.find_by(name: name)

    render(json: { errors: [{ detail: "Access Denied" }] }, status: 401) unless valid_key(token)
  end

  ## Secure compare DB with token & name
  
  def valid_key(token)
    @api_client && ActiveSupport::SecurityUtils.secure_compare(@api_client&.key, Digest::SHA512.hexdigest(token))
  end
end

