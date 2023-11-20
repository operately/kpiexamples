class AddPendingToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :pending, :boolean, default: true
  end
end
