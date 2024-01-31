# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:report) { FactoryBot.create(:report, user: user1) }

  describe '#editable?' do
    it 'returns true when the report is created by the user' do
      expect(report.editable?(user1)).to be_truthy
    end

    it 'returns false when the report is not created by the user' do
      expect(report.editable?(user2)).to be_falsey
    end
  end

  describe '#created_on' do
    it 'returns the date when the report is created' do
      report.created_at = Time.zone.local(2024, 1, 1, 0, 0, 0)

      expect(report.created_on).to eq(Date.new(2024, 1, 1))
    end
  end
end
