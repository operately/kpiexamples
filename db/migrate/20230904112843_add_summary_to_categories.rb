class AddSummaryToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :summary, :text
  end
end
