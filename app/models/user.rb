class User < ApplicationRecord

    attr_accessor :remember_token
    before_save { self.email = email.downcase }

    
    # =====Validation======
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝
    
    # ＝＝＝＝関連付け＝＝＝＝＝
    has_many :favorites, dependent: :destroy #favoritesとの関連づけ
    has_many :favorite_items, through: :favorites #userモデルからfavorite_itemへ直接関連付けを定義
    has_many :favorite_datas, through: :favorites 
    has_many :bookmarks, dependent: :destroy
    has_many :likes, dependent: :destroy
    # 下記の記述はuser.bookmarks.map(&:favorite) = arr.map{|x| x.id}これをしているのと一緒
    has_many :bookmark_favorites, through: :bookmarks, source: :favorite #多対多で中間テーブルの先のモデルとアソシエーションする。これでユーザーがブックマークしたfavoriteを一気に取得できる
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
        update_attribute(:remember_digest, User.digest(remember_token)) #update_attributeは記憶ダイジェストを更新 ※バリデーションを素通りさせる必要あり
    end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # ユーザーのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end

    # パスワード再設定の属性を設定する
    def send_activation_email
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token)) 
        update
    end

     # 引数に渡されたものが、userのものであるか？
    def own?(object)
        id == object.user_id
    end

      # 引数に渡されたfavoriteがブックマークされているか？
    def bookmark?(favorite)
        bookmark_favorites.include?(favorite)
    end

    # favorite_idを入れてブックマークしてください
    def bookmark(favorite)
        # current_userがブックマークしているfavoriteの配列にfavoriteを入れる
        bookmark_favorites << favorite
    end

    # 引数のfavoriteのidをもつ、レコードを削除してください
    def unbookmark(favorite)
        bookmark_favorites.destroy(favorite)
    end


end
