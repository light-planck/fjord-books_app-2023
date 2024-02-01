# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = users(:user1)
    assert_equal 'user1@example.com', user.name_or_email

    user2 = users(:user2)
    assert_equal 'User 2', user2.name_or_email
  end
end
