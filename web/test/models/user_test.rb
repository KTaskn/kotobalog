require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "passowrd digest" do
    name = 'name'
    password = 'test_password'
    user = User.create(name: name, password: password)
    user.save()

    user_load = User.find_by(name: name)    
    assert user_load.name == name
    assert user_load.password_digest != password
  end
end
