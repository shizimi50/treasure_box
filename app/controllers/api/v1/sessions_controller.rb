module Api
  module V1
    class SessionsController < ApplicationController
      include SessionsHelper
      before_action :require_login, except: [:create]
      
      # GET | /api/v1/users/current_user
      def index
          render json: { message: "#{session[:user_name]}でログインしています。" }
      end
      
      # ログイン POST | /api/v1/users/login (フロントから { email: 'メールアドレス', password: 'パスワード' }が送信される)
      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:user_name] = user.name
          payload = { message: 'ログインしました', name: user.name}
        else
          payload = { errors: 'メールアドレスまたはパスワードが正しくありません。'}
        end
          render json: payload
      end

      #ログアウト DELETE | /api/v1/users/logout
      def destroy
        log_out
        render json: { message: 'ログアウトしました' }
      end

    end
  end
end
