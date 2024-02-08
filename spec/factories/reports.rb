# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    sequence(:title) { |n| "Report #{n}" }
    sequence(:content) { |n| "Content #{n}" }
    association :user
  end
end
