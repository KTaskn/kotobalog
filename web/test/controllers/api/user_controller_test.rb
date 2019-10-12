require 'test_helper'

class Api::UserControllerTest < ActionDispatch::IntegrationTest
  test "should post signup" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    
    user = User.find_by(name: name)
    assert user.name == name
    assert user.password_digest != password
    assert user.email == email

    name = 'test_name_1'
    password = 'test_password'
    email = 'email_2@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result'] == false
    
    name = 'test_name_2'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result'] == false
    
    user = User.find_by(name: name)
  end

  test "signup error other passwordcheck" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': 'other',
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']
  end

  test "should get signin" do
    # ユーザを作成
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }

    post api_user_signin_url, params: {
      name: name,
      password: password
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert User.find_by(name: name).check_access_token(json['access_token'])
    assert User.find_by(name: name).check_refresh_token(json['refresh_token'])


    post api_user_signout_url params: {
      name: name,
      access_token: json['access_token']
    }
    assert_response :success
    assert_not User.find_by(name: name).check_access_token(json['access_token'])
    assert_not User.find_by(name: name).check_refresh_token(json['refresh_token'])
  end

  test "signin bad pattern" do
    # ユーザを作成
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_signup_url, params: {
        'name': name,
        'password': password,
        'password_check': password,
        'email': email
      }

    post api_user_signin_url, params: {
      name: name,
      password: password
    }

    post api_user_signin_url, params: {
      name: name,
      password: 'other_password'
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']
    assert_not User.find_by(name: name).check_access_token(json['access_token'])
    assert_not User.find_by(name: name).check_refresh_token(json['refresh_token'])

    post api_user_signin_url, params: {
      name: 'notset_name',
      password: password
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert_not json['result']
    assert_not User.find_by(name: name).check_access_token(json['access_token'])
    assert_not User.find_by(name: name).check_refresh_token(json['refresh_token'])

  end


end
