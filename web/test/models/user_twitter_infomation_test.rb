require 'test_helper'

class UserTwitterInfomationTest < ActiveSupport::TestCase
  test "check unique twitter_id" do
    user_1 = User.create(name: 'name1', password: 'test_password1', email: 'test_email_1@example.com')
    user_2 = User.create(name: 'name2', password: 'test_password2', email: 'test_email_2@example.com')
    user_3 = User.create(name: 'name3', password: 'test_password3', email: 'test_email_3@example.com')

    obj_1 = UserTwitterInfomation.new(
      user: user_1,
      twitter_id: 1
    )
    assert obj_1.save

    obj_2 = UserTwitterInfomation.new(
      user: user_2,
      twitter_id: 2
    )
    assert obj_2.save

    obj_1_err = UserTwitterInfomation.new(
      user: user_1,
      twitter_id: 3
    )
    assert_not obj_1_err.save

    obj_3_err = UserTwitterInfomation.new(
      user: user_3,
      twitter_id: 2
    )
    assert_not obj_3_err.save
  end
end
