# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '#editable?' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:report) { FactoryBot.create(:report, user: user1) }

    it 'returns true when the report is created by the user' do
      expect(report.editable?(user1)).to be_truthy
    end

    it 'returns false when the report is not created by the user' do
      expect(report.editable?(user2)).to be_falsey
    end
  end
end
