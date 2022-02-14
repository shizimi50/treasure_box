class FavoriteSerializer < ActiveModel::Serializer
  attribute :id, :theme, :user_id, :image_path, :deleted_at

  # has_many :favorite_datas
end
