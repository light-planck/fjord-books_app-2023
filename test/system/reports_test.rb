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

  test 'should update Report' do
    visit reports_url
    click_on 'この日報を表示', match: :first
    assert_text '日報の詳細'

    click_on 'この日報を編集'
    assert_text '日報の編集'

    fill_in 'タイトル', with: 'フィヨルドブートキャンプの感想'
    fill_in '内容', with: '学びが多い'
    click_on '更新する'

    assert_text '日報が更新されました。'
  end

  # test 'should destroy Report' do
  #   visit report_url(@report)
  #   click_on 'Destroy this report', match: :first

  #   assert_text 'Report was successfully destroyed'
  # end
end
