module Api
  module V1
    class SessionsController < ApplicationController
      before_action :require_login, except: [:create]
      
      # GET | /api/v1/users/current_user
      def index
          render json: { message: "#{session[:user_name]}でログインしています。" }
      end
      
      # ログイン POST | /api/v1/users/login (フロントから { email: 'メールアドレス', password: 'パスワード' }が送信される)
      def create
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          if user.activated?
            log_in user
            params[:remember_me] == '1' ? remember(user) : forget(user)
            redirect_back_or user
          else
            payload  = "アカウントが有効ではありません。"
            payload += "メールアドレスからリンクを確認してください。"
          end
        else
          payload = { errors: 'メールアドレスまたはパスワードが正しくありません。'}
        end
          render json: payload
      end

      #ログアウト DELETE | /api/v1/users/logout
      def destroy
        log_out if logged_in?
        render json: { message: 'ログアウトしました' }
      end

    end
  end
end