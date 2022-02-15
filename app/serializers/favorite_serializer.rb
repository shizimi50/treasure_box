class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :theme, :user_id, :image_path

  has_many :favorite_datas
end