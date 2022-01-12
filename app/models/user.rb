class User < ApplicationRecord

    attr_accessor :remember_token, :activation_token
    before_save   :downcase_email #オブジェクトが保存される直前、オブジェクトの作成時や更新時にそのコールバックが呼び出される
    before_create :create_activation_digest #オブジェクトが作成されたときのみコールバックを呼び出す（別名：メソッド参照）
    
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
    has_secure_password # パスワードのハッシュ化/2つのペアの仮想的な属性/authenticateメソッド利用化
    mount_uploader :photo_path, ImageUploader #「アップロード画像用のカラム」と「アップローダークラス」を紐づけ
    acts_as_paranoid #論理削除適用
    # ＝＝＝＝＝＝＝＝＝＝＝＝＝
    
    # 渡された文字列ハッシュ値を返す
    def User.digest(string) #クラスメソッド：インスタンスではなくクラス本体に紐付けられるメソッド
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

     # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する（仮想属性（remember_token）のためのコード）
    def remember
        self.remember_token = User.new_token #self使うことで代入を実現
        # ↓ 記憶トークンやダイジェストは既にデータベースにいるユーザーのために作成される
        update_attribute(:remember_digest, User.digest(remember_token)) #update_attributeは記憶ダイジェストを更新 ※バリデーションを素通りさせる必要あり
    end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
      # 他の認証でも利用できるよう引数の名前を一般化すると良い（リファクタリング）
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest") # 受け取ったパラメータに応じて呼び出すメソッドを切り替える手法（メタプログラミング = プログラムでプログラムを作成する）/モデル内のためself省略
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
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

    #アカウントを有効にする
    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    # 有効化用のメールを送信する
    def send_activation_email
        update_attribute(:activation(self).deliver_now)
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

    private

    def downcase_email
        email.downcase!                                                             # emailを小文字化してUserオブジェクトのemail属性に代入
        # self.email = email.downcase
    end
    
    def create_activation_digest  
        self.activation_token  = User.new_token  # 有効化トークンを作成および代入する
        self.activation_digest = User.digest(activation_token) # ダイジェストを作成および代入する
    end


end
