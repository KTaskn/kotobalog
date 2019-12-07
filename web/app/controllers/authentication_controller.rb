class AuthenticationController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :check_access_token
  
  protected def check_access_token
    authorized = authenticate_token() || render_unauthorized()
  end

  def authenticate_token
    name = params[:name]
    user = User.find_by(name: name)
    authenticate_or_request_with_http_token do |token, options|
      return user.check_access_token(token)
    end    
  end

  def render_unauthorized
    # POSTの場合は認証できないでエラー
    render :json => {
      'result': false
    }, status: :unauthorized
  end
end
