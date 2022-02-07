class Api::V1::ApplicationController < ActionController::API
    include ActionController::Cookies
    include SessionsHelper
    # before_action :check_xhr_header #リクエストがxhrであることをチェックする

    private

    def check_xhr_header #固有の HTTP ヘッダでCSRF対策
        return if request.xhr?
        
        render json: { error: 'forbidden' }, status: :forbidden
    end
    
    def require_login
        @current_user = User.find_by(id: session[:user_id]) #ログインユーザーかどうかを判定
        return if @current_user
        render json: { message: "unauthorized" }, status: 401
    end

end
