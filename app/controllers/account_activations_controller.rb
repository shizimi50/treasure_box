class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])

        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.activate
            log_in user
            payload = { success: "Account activated!"}
        else
            payload = { errors: "Invalid activation link"}
        end
        render json: payload

    end
end
