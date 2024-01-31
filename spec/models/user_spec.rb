# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name_or_email' do
    it 'returns the name when the user has a name' do
      has_name_user = FactoryBot.create(:user)
      expect(has_name_user.name_or_email).to eq(has_name_user.name)
    end

    it 'returns the email when the user does not have a name' do
      has_no_name_user = FactoryBot.create(:user, name: nil)
      expect(has_no_name_user.name_or_email).to eq(has_no_name_user.email)
    end
  end
end
