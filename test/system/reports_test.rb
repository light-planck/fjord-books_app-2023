# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_path
    assert_text 'ログイン'

    fill_in 'Eメール', with: 'user1@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'should create report' do
    visit reports_url

    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'フィヨルドでのコードレビュー'
    fill_in '内容', with: 'レビューを通して自分のコードがより良くなるのを実感する'
    click_on '登録する'

    assert_text '日報が作成されました。'
  end

  # test 'should update Report' do
  #   visit report_url(@report)
  #   click_on 'Edit this report', match: :first

  #   fill_in 'Content', with: @report.content
  #   fill_in 'Title', with: @report.title
  #   fill_in 'User', with: @report.user_id
  #   click_on 'Update Report'

  #   assert_text 'Report was successfully updated'
  #   click_on 'Back'
  # end

  # test 'should destroy Report' do
  #   visit report_url(@report)
  #   click_on 'Destroy this report', match: :first

  #   assert_text 'Report was successfully destroyed'
  # end
end
