class CreateFavoriteValues < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_values do |t|
      t.references :favorite_data, null: false, foreign_key: true
      t.references :favorite_item, null: false, foreign_key: true
      t.text :value, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
