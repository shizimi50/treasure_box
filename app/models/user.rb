class User < ApplicationRecord

    attr_accessor :remember_token
    
    # =====Validation======
    validates :name, presence: true #空の値に対してバリデーション設定
    validates :email, presence: true, uniqueness: true #email、reset_password_tokenカラムに空の値、重複に対してバリデーション設定
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝＝＝関連付け＝＝＝＝＝
    has_many :favorites, dependent: :destroy #favoritesとの関連づけ
    has_many :favorite_items, through: :favorites #userモデルからfavorite_itemへ直接関連付けを定義
    has_many :favorite_datas, through: :favorites 
    has_many :bookmarks, dependent: :destroy
    has_many :likes, dependent: :destroy
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝

    # ＝＝フレームワーク関連＝＝
    has_secure_password # パスワードのハッシュ化
    mount_uploader :photo_path, ImageUploader #「アップロード画像用のカラム」と「アップローダークラス」を紐づけ
    acts_as_paranoid #論理削除適用
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝


    # 渡された文字列ハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

     # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # パスワード再設定の属性を設定する
    def send_activation_email
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update
    end

end
