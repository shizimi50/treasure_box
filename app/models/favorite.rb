class Favorite < ApplicationRecord

    # =====Validation======
    validates :theme, :user_id, presence: true #空の値に対してバリデーション設定
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝＝＝関連付け＝＝＝＝＝
    belongs_to :user #userとの関連付け
    has_many :favorite_items, dependent: :destroy #favorite_itemsとの関連づけ
    has_many :favorite_datas, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝フレームワーク関連＝＝
    mount_uploader :image_path, ImageUploader #「Favoriteテーマアップロード画像用のカラム」と「アップローダークラス」を紐づけ
    acts_as_paranoid #論理削除適用
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    def myfavorites
        Favorite.where(user_id: current_user.id) #MyFavorite
    end

    def othersfavorites
        Favorite.where.not(user_id: current_user.id).order(updated_at: :desc).limit(3) #Others Latest Favorite
    end

    def rankingfavorites
        FavoriteData.where(star: 5).limit(3) # Favorite Ranking
    end

    scope :has_favorite_id, -> favorite_id {
        joins(:favorite_datas).merge(FavoriteData.where(favorite_id: favorite_id))
    }

    def self.search(search) #self.でクラスメソッドとしている
        if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
          Project.where(['theme LIKE ?', "%#{search}%"])
        else
          Project.all #全て表示。
        end
      end

    
end
