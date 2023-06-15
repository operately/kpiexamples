class AddSlugToKpis < ActiveRecord::Migration[7.0]
  def change
    add_column :kpis, :slug, :string
    add_index :kpis, :slug, unique: true
  end
end
