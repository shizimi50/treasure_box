class AddIndexToFavoritesDeletedAt < ActiveRecord::Migration[6.1]
  def change
    add_index :favorites, :deleted_at
  end
end
