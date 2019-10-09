class Api::UserController < ApplicationController
  def create
    name = params[:name]
    password = params[:password]
    email = params[:email]

    new_user = User.create(
      name: name,
      password: password,
      email: email
    )

    result = new_user.save()

    if result then
      result_json = {
        'result': true
      }
    else
      result_json = {
        'result': false
      }
    end

    render :json => result_json
  end

  def login
    name = params[:name]
    password = params[:password]

    user = User.find_by(name: name)

    result = false
    if user then
      result, access_token, refresh_token = user.login(password)
    end

    render :json => {
      'result': result,
      'access_token': access_token.nil? ? '' : access_token.token,
      'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
    }
  end

  def logout
    name = params[:name]
    str_access_token = params[:access_token]
    user = User.find_by(name: name)
    if user.check_access_token(str_access_token) then
      user.logout()
      render :json => {
        'result': true
      }
    else
      render :json => {
        'result': false
      }
    end
  end
end
