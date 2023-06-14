class CreateKpis < ActiveRecord::Migration[7.0]
  def change
    create_table :kpis do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.string :unit
      t.text :description
      t.text :formula
      t.text :example

      t.timestamps
    end
  end
end
