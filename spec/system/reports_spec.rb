# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:report) { FactoryBot.create(:report) }

  before do
    driven_by(:rack_test)
  end

  scenario 'User creates a new report' do
    sign_in user

    expect do
      visit reports_url

      click_on '日報の新規作成'
      fill_in 'タイトル', with: 'title'
      fill_in '内容', with: 'content'
      click_on '登録する'

      assert_text '日報が作成されました。'
    end.to change(Report, :count).by(1)
  end
end
