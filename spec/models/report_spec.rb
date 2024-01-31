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

  describe '#save_mentions' do
    let(:report1) { FactoryBot.create(:report) }
    let(:report2) { FactoryBot.create(:report, content: "http://localhost:3000/reports/#{report1.id}}") }
    let(:report3) { FactoryBot.create(:report, content: "http://localhost:3000/reports/#{report1.id} http://localhost:3000/reports/#{report2.id}") }

    it 'saves mention' do
      expect(report2.mentioning_reports).to eq [report1]
    end

    it 'save multiple mentions' do
      expect(report3.mentioning_reports).to eq [report1, report2]
    end

    it 'is updated when the report is updated' do
      report3.update!(content: 'http://localhost:3000/reports/1')
      report3.reload

      expect(report3.mentioning_reports).to eq [report1]
    end

    it 'is updated when the report is deleted' do
      report2.destroy!
      report3.destroy!

      expect(report1.mentioning_reports).to eq []
    end
  end
end
