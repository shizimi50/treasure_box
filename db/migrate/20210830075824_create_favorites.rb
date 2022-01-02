class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.string :theme, :null => false
      t.string :image_path
      t.references :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
