module Api
    module V1
        class PasswordResetsController < ApplicationController

            def create
                user = User.find_by(email: params[:email].downcase)
                if user
                    user.create_reset_digest
                    user.send_password_reset_email
                    render json: {stasus: 200, message: "パスワード再設定の案内メールを送信"}
                else
                    render json: {status: 422, message: "メールアドレスが見つかりません"}
                end
            end
        end

    end
end