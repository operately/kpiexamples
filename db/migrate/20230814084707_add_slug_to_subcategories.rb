class AddSlugToSubcategories < ActiveRecord::Migration[7.0]
  def change
    add_column :subcategories, :slug, :string
    add_index :subcategories, [:slug, :category_id], unique: true
  end
end
