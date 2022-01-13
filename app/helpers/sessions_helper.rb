module SessionsHelper
    # 渡されたユーザーでログインする（ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成される）
     def log_in(user)
       session[:user_id] = user.id
     end

    # ユーザーのセッションを永続的にする
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # 記憶トークンcookieに対応するユーザーを返す
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
              log_in user
              @current_user = user
            end
        end
    end

     #受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
    def current_user?(user)
        user == current_user
    end

     # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end

    #永続的セッションを破壊する
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    
    # 現在のユーザーをログアウトする
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    
    # 記憶したURL（もしくはデフォルト値）にリダイレクト
    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end

    # アクセスしようとしたURLを覚えておく
    def store_location
        session[:forwarding_url] = requset.original_url if requset.get?
    end

end