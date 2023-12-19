# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    user1 = users(:user1)
    user2 = users(:user2)
    report1 = reports(:report1)

    assert report1.editable?(user1)
    assert_not report1.editable?(user2)
  end

  test '#created_on' do
    report1 = reports(:report1)

    assert_equal Date.new(2024, 1, 1), report1.created_on
  end
end
