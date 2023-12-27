# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    user1 = users(:user1)
    user2 = users(:user2)
    report = reports(:report1)

    assert report.editable?(user1)
    assert_not report.editable?(user2)
  end

  test '#created_on' do
    report = reports(:report1)

    assert_equal Date.current, report.created_on
  end

  test '#save_mentions' do
    report1 = reports(:report1)
    report1.save!

    report2 = reports(:report2)
    report2.save!

    # 言及
    assert_equal [report1], report2.mentioning_reports

    # 複数個の言及
    report3 = reports(:report3)
    report3.save!

    assert_equal [report1, report2], report3.mentioning_reports

    # 更新
    report2.update!(content: "http://localhost:3000/reports/#{report3.id}")
    report2.reload

    assert_equal [report3], report2.mentioning_reports

    report2.update!(content: '.')
    report2.reload

    assert_equal [], report2.mentioning_reports

    # 削除
    report2.destroy!
    report3.destroy!

    assert_equal [], report1.mentioned_reports
  end
end
