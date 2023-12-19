# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = users(:one)
    assert_equal 'test@example.com', user.name_or_email

    user2 = users(:two)
    assert_equal 'test2', user2.name_or_email
  end
end
