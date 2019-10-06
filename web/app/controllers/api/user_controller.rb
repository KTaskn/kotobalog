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
    
    if user and user.authenticate(password) then
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

  def logout
  end
end
