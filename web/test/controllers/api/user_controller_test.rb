require 'test_helper'

class Api::UserControllerTest < ActionDispatch::IntegrationTest
  test "should post create" do
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_create_url, params: {
        'name': name,
        'password': password,
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
    post api_user_create_url, params: {
        'name': name,
        'password': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result'] == false
    
    name = 'test_name_2'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_create_url, params: {
        'name': name,
        'password': password,
        'email': email
      }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result'] == false
    
    user = User.find_by(name: name)
  end

  test "should get login" do
    # ユーザを作成
    name = 'test_name_1'
    password = 'test_password'
    email = 'email_1@example.com'
    post api_user_create_url, params: {
      'name': name,
      'password': password,
      'email': email
    }


    post api_user_login_url, params: {
      name: name,
      password: password
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']

    post api_user_login_url, params: {
      name: name,
      password: 'other_password'
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result'] == false

    post api_user_login_url, params: {
      name: 'notset_name',
      password: password
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result'] == false
  end

  test "should get logout" do
    get api_user_logout_url
    assert_response :success
  end

end
