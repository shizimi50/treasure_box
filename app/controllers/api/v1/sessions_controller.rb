module Api
  module V1
    class SessionsController < ApplicationController
      before_action :require_login, except: [:create]
      
      # ログイン POST | /api/v1/users/login (フロントから { email: 'メールアドレス', password: 'パスワード' }が送信される)
      def create
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          if user.activated?
            log_in user
            params[:remember_me] == '1' ? remember(user) : forget(user)
            render json: { message: 'ログインしました', data: user }
            # redirect_back_or user
          else
            render json: { message: 'アカウントが有効ではありません。メールアドレスからリンクを確認してください。' }
          end
        else
          render json: { errors: 'メールアドレスまたはパスワードが正しくありません。'}
        end
      end

      #ログアウト DELETE | /api/v1/users/logout
      def destroy
        log_out if logged_in?
        render json: { message: 'ログアウトしました' }
      end

    end
  end
end