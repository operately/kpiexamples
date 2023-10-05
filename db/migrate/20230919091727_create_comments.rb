class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :parent_id, foreign_key: true

      t.timestamps
    end
  end
end
