class CreateFavoriteData < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_data do |t|
      t.references :favorite, null: false, foreign_key: true
      t.string :title, null: false
      t.string :image_path
      t.integer :star, null: false
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
