class CreateKpiUpvotes < ActiveRecord::Migration[7.0]
  def change
    create_table :kpi_upvotes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :kpi, null: false, foreign_key: true

      t.timestamps
    end

    add_index :kpi_upvotes, [:user_id, :kpi_id], unique: true
  end
end
