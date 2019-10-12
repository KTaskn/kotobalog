class Api::UserController < ApplicationController
  protect_from_forgery
  def signup
    name = params[:name]
    password = params[:password]
    password_check = params[:password_check]
    email = params[:email]

    result = User.signup(
      name,
      password,
      password_check,
      email
    )

    if result then
      user = User.find_by(name: name)
      
      if user then
        result, access_token, refresh_token = user.signin(password)
      end

      result_json = {
        'result': result,
        'name': name,
        'access_token': access_token.nil? ? '' : access_token.token,
        'access_token_expiration': access_token.nil? ? '' : access_token.expiration,
        'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
        'refresh_token_expiration': refresh_token.nil? ? '' : refresh_token.expiration
      }
    else
      result_json = {
        'result': false
      }
    end

      render :json => result_json
  end

  def signin
    name = params[:name]
    password = params[:password]

    user = User.find_by(name: name)

    result = false
    if user then
      result, access_token, refresh_token = user.signin(password)
    end

    render :json => {
      'result': result,
      'access_token': access_token.nil? ? '' : access_token.token,
      'access_token_expiration': access_token.nil? ? '' : access_token.expiration,
      'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
      'refresh_token_expiration': refresh_token.nil? ? '' : refresh_token.expiration
    }
  end

  def signout
    name = params[:name]
    str_access_token = params[:access_token]
    user = User.find_by(name: name)
    if user.check_access_token(str_access_token) then
      user.signout()
      render :json => {
        'result': true
      }
    else
      render :json => {
        'result': false
      }
    end
  end

  def refresh
    name = params[:name]
    str_refresh_token = params[:refresh_token]

    user = User.find_by(name: name)

    result = false
    if user then
      result, access_token, refresh_token = user.refresh(str_refresh_token)
    end

    render :json => {
      'result': result,
      'name': name,
      'access_token': access_token.nil? ? '' : access_token.token,
      'access_token_expiration': access_token.nil? ? '' : access_token.expiration,
      'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
      'refresh_token_expiration': refresh_token.nil? ? '' : refresh_token.expiration
    }
  end
end
