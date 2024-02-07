# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  let(:user) { create(:user) }
  let(:report) { create(:report) }

  before do
    driven_by(:rack_test)
  end

  scenario 'User creates a new report' do
    sign_in user
    visit reports_url

    expect do
      click_on '日報の新規作成'
      fill_in 'タイトル', with: 'title'
      fill_in '内容', with: 'content'
      click_on '登録する'
    end.to change(Report, :count).by(1)

    assert_text '日報が作成されました。'
    assert_text 'title'
    assert_text 'content'
  end

  scenario 'User edits a report' do
    sign_in user
    report = create(:report, user:)
    visit reports_url

    click_on 'この日報を表示', match: :first
    assert_text '日報の詳細'

    click_on 'この日報を編集'
    assert_text '日報の編集'

    fill_in 'タイトル', with: 'フィヨルドブートキャンプの感想'
    fill_in '内容', with: '学びが多い'
    click_on '更新する'

    assert_text '日報が更新されました。'

    expect(report.reload.title).to eq 'フィヨルドブートキャンプの感想'
    expect(report.reload.content).to eq '学びが多い'
  end

  scenario 'User deletes a report' do
    sign_in user
    create(:report, user:)
    visit reports_url

    expect do
      click_on 'この日報を表示', match: :first
      assert_text '日報の詳細'

      click_on 'この日報を削除'
      assert_text '日報が削除されました。'
    end.to change(Report, :count).by(-1)
  end
end
