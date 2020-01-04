require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "signup" do
    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    result = User.signup(name, password, password, email)

    assert result

    user_load = User.find_by(name: name)
    assert user_load.name == name
    assert user_load.email == email
    assert user_load.password_digest != password
  end

  test "signup error" do
    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    result = User.signup(name, password, 'other', email)

    assert_not result

    user_load = User.find_by(name: name)    
    assert_not user_load
  end

  test "passowrd digest" do
    name = 'name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    user_load = User.find_by(name: name)    
    assert user_load.name == name
    assert user_load.email == email
    assert user_load.password_digest != password
  end

  test "validation name" do
    password = 'test_password'
    email = 'test_email@example.com'

    # 空白
    user = User.create(name: '', password: password, email: email)
    assert_not user.save()

    # 長さ15文字以下 -> OK
    user = User.create(name: '1234567890ABCDEF', password: password, email: email)
    assert user.save()

    # 長さ16文字以上 -> NG
    user = User.create(name: '1234567890ABCDEFZ', password: password, email: email)
    assert_not user.save()

    # 特殊記号
    user = User.create(name: 'fuga%', password: password, email: email)
    assert_not user.save()
  end

  test "validation email" do
    name = 'test_name'
    password = 'test_password'

    # 空白
    user = User.create(name: name, password: password, email: '')
    assert_not user.save()

    # メールアドレスでない
    user = User.create(name: name, password: password, email: 'fugafuga')
    assert_not user.save()
  end

  test "user check_access_token" do
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    assert_not user.check_access_token('other string')

    token_1 = AccessToken.refresh(user)
    assert user.check_access_token(token_1.token)
    assert_not user.check_access_token('other string')
  end

  test "user check_refresh_token" do
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    assert_not user.check_refresh_token('other string')

    token_1 = RefreshToken.refresh(user)
    assert user.check_refresh_token(token_1.token)
    assert_not user.check_refresh_token('other string')
  end

  test "signin and signout" do
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    result, access_token, refresh_token = user.signin(password)
    assert result
    assert user.check_access_token(access_token.token)
    assert user.check_refresh_token(refresh_token.token)
    assert AccessToken.find_by(user: user)
    assert RefreshToken.find_by(user: user)

    user.signout()
    assert_not AccessToken.find_by(user: user)
    assert_not RefreshToken.find_by(user: user)
  end

  test "signin bad unmatch password" do
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    result, access_token, refresh_token = user.signin('other password')
    assert_not result
    assert_not access_token
    assert_not refresh_token
    assert_not AccessToken.find_by(user: user)
    assert_not RefreshToken.find_by(user: user)
  end

  test "refresh" do
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    result, access_token, refresh_token = user.signin(password)
    assert result
    assert user.check_access_token(access_token.token)
    assert user.check_refresh_token(refresh_token.token)
    assert AccessToken.find_by(user: user)
    assert RefreshToken.find_by(user: user)

    result, access_token, refresh_token = user.refresh(refresh_token.token)
    assert result
    assert user.check_access_token(access_token.token)
    assert user.check_refresh_token(refresh_token.token)
    assert AccessToken.find_by(user: user)
    assert RefreshToken.find_by(user: user)

  end

end
