require 'test_helper'

class AccessTokenTest < ActiveSupport::TestCase
  test "refresh" do  
    name = 'test_name'
    password = 'test_password'
    email = 'test_email@example.com'
    user = User.create(name: name, password: password, email: email)
    user.save()

    token_1 = AccessToken.refresh(user)
    assert token_1
    assert AccessToken.where(user: user).count == 1

    token_2 = AccessToken.refresh(user)
    assert AccessToken.where(user: user).count == 1
    assert token_1.token != token_2.token

    token_new = AccessToken.find_by(user: user)
    assert token_1.token != token_new.token
  end
end
