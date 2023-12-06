class AddTitleAndContentToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :title, :string
    add_column :reports, :content, :text
  end
end
