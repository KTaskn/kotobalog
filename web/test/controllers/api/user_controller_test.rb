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
    assert json['access_token']
    assert json['refresh_token']
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']
    assert json['name'] == name
    
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
      name_or_email: name,
      password: password
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert User.find_by(name: name).check_access_token(json['access_token'])
    assert User.find_by(name: name).check_refresh_token(json['refresh_token'])
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']

    post api_user_signout_url, params: {
      'name': name,
    },
    headers: {
      'Authorization': 'Token %s' % json['access_token']
    }
    assert_response :success
    assert_not User.find_by(name: name).check_access_token(json['access_token'])
    assert_not User.find_by(name: name).check_refresh_token(json['refresh_token'])
  end


  test "should bad signout" do
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
      name_or_email: name,
      password: password
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert User.find_by(name: name).check_access_token(json['access_token'])
    assert User.find_by(name: name).check_refresh_token(json['refresh_token'])
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']

    post api_user_signout_url, params: {
      'name': name,
    },
    headers: {
      'Authorization': 'Token %s' % 'other'
    }
    assert_response :unauthorized
    assert User.find_by(name: name).check_access_token(json['access_token'])
    assert User.find_by(name: name).check_refresh_token(json['refresh_token'])
  end

  test "should get signin email" do
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
      name_or_email: email,
      password: password
    }
    
    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert User.find_by(name: name).check_access_token(json['access_token'])
    assert User.find_by(name: name).check_refresh_token(json['refresh_token'])
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']

    post api_user_signout_url, params: {
      'name': name,
    },
    headers: {
      'Authorization': 'Token %s' % json['access_token']
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

  test "should post refresh" do
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
    assert json['access_token']
    assert json['refresh_token']
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']
    assert json['name'] == name
    
    user = User.find_by(name: name)
    assert user.name == name
    assert user.password_digest != password
    assert user.email == email

    access_token_1 = json['access_token']
    refresh_token_1 = json['refresh_token']

    post api_user_refresh_url, params: {
      'name': name,
    },
    headers: {
      'Authorization': 'Token %s' % json['refresh_token']
    }

    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['access_token']
    assert json['refresh_token']
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']
    assert_not json['access_token'] == access_token_1
    assert_not json['refresh_token'] == refresh_token_1

    post api_user_refresh_url, params: {
      'name': name,
    },
    headers: {
      'Authorization': 'Token %s' % 'other'
    }
    assert_response :unauthorized


    post api_user_refresh_url, params: {
      'name': name
    }
    assert_response :unauthorized
  end

  test "check namecheck" do
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
    assert json['access_token']
    assert json['refresh_token']
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']
    assert json['name'] == name

    get api_user_namecheck_url, params: {
      'name': name
    }

    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['is_duplicated']


    get api_user_namecheck_url, params: {
      'name': 'other'
    }

    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert_not json['is_duplicated']


    get api_user_namecheck_url
    assert_response :bad_request
  end

  test "check emailcheck" do
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
    assert json['access_token']
    assert json['refresh_token']
    assert json['access_token_expiration']
    assert json['refresh_token_expiration']
    assert json['name'] == name

    get api_user_emailcheck_url, params: {
      'email': email
    }

    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert json['is_duplicated']


    get api_user_emailcheck_url, params: {
      'email': 'other'
    }

    json = JSON.parse(response.body)
    assert_response :success
    assert json['result']
    assert_not json['is_duplicated']


    get api_user_emailcheck_url
    assert_response :bad_request
  end
end
