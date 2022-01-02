class FavoriteData < ApplicationRecord
    # =====Validation======
    validates :title, :star, :user_id, presence: true #空の値に対してバリデーション設定
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝
    
    # ＝＝＝＝関連付け＝＝＝＝＝
    belongs_to :favorite
    belongs_to :user
    has_many :favorite_values
    has_many :likes
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝フレームワーク関連＝＝
    mount_uploader :image_path, ImageUploader
    acts_as_paranoid 
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝
end
