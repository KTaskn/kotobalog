require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "passowrd digest" do
    name = 'name'
    password = 'test_password'
    email = 'test_email'
    user = User.create(name: name, password: password, email: email)
    user.save()

    user_load = User.find_by(name: name)    
    assert user_load.name == name
    assert user_load.email == email
    assert user_load.password_digest != password
  end
end
