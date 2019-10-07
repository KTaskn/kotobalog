require 'test_helper'

class UserTest < ActiveSupport::TestCase
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

    token_1 = AccessToken.refresh(user)
    assert user.check_access_token(token_1.token)
    assert_not user.check_access_token('other string')
  end

end
