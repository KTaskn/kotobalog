require 'test_helper'

class RefreshTokenTest < ActiveSupport::TestCase
  test "refresh" do  
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    token_1 = RefreshToken.refresh(user)
    assert token_1
    assert RefreshToken.where(user: user).count == 1

    token_2 = RefreshToken.refresh(user)
    assert RefreshToken.where(user: user).count == 1
    assert token_1.token != token_2.token

    token_new = RefreshToken.find_by(user: user)
    assert token_1.token != token_new.token
  end

  test "check" do
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    token_1 = RefreshToken.refresh(user)
    assert token_1.check(token_1.token)
    assert_not token_1.check('other string')    
  end

  test "remove" do
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    token_1 = RefreshToken.refresh(user)
    assert token_1
    assert RefreshToken.where(user: user).count == 1
    token_1.remove()
    assert RefreshToken.where(user: user).count == 0
  end
end
