class CreateFavoriteItems < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_items do |t|
      t.references :favorite, null: false, foreign_key: true
      t.string :name, :null => false
      t.integer :type, :null => false
      t.integer :order, :null => false
      t.text :select_options
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
