class Bookmark < ApplicationRecord
    # =====Validation======
    validates :favorite_id, :user_id, presence: true #空の値に対してバリデーション設定
    validates :user_id, uniqueness: { scope: :favorite_id } # user_id と favorite_idの組み合わせを一意性のあるものにしている
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝＝＝関連付け＝＝＝＝＝
    belongs_to :favorite
    belongs_to :user
    # belongs_to :like #Validation failed: Like must exist対策のため一旦コメントアウト
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝フレームワーク関連＝＝
    acts_as_paranoid #論理削除適用
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝
end
