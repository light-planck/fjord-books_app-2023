# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  has_many :mentions_out, class_name: 'ReportMention', foreign_key: :mentioned_id, dependent: :destroy
  has_many :mentioning_reports, through: :mentions_out, source: :mentioning

  has_many :mentions_in, class_name: 'ReportMention', foreign_key: :mentioning_id, dependent: :destroy
  has_many :mentioned_reports, through: :mentions_in, source: :mentioned

  after_save :update_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def update_mentions
    mentions_out.destroy_all

    content.scan(/http:\/\/localhost:3000\/reports\/(\d+)/).uniq.each do |report_id|
      report = Report.find_by(id: report_id)
      mentioning_reports << report if report
    end
  end
end
