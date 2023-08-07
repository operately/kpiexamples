class AddSubcategoryIdToKpis < ActiveRecord::Migration[7.0]
  def change
    add_column :kpis, :subcategory_id, :integer
    add_index :kpis, :subcategory_id
  end
end
