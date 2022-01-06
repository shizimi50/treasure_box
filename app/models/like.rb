class Like < ApplicationRecord
    # =====Validation======
    validates :favorite_data_id, :user_id, presence: true #空の値に対してバリデーション設定
    validates :user_id, uniqueness: { scope: :favorite_data_id } # user_id と favorite_data_idの組み合わせを一意性に
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝＝＝関連付け＝＝＝＝＝
    belongs_to :favorite_data
    belongs_to :user
    # has_many :bookmarks Validation failed: Like must exist対策のため一旦コメントアウト
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝フレームワーク関連＝＝
    acts_as_paranoid #論理削除適用
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝
end
