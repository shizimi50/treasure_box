module Api
    module V1
        class UsersController < ApplicationController
            before_action :require_login, except: [:create]
            before_action :user_params_create, only: [:create]
            before_action :user_params, only: [:destroy, :update]
            before_action :set_user, only: [:show, :update, :destroy]


            def index
                users = User.all
                render json: users
            end
        
            def show
                render json: @user
            end

            def create
                user = User.new(user_params_create)
                if user.save
                    render json: user
                else
                    render json: user.errors.full_messages #"Email has already been taken"
                end
            end

            def update
                if @user.update(user_params)
                    render json: @user
                else
                    render json: @user.errors
                end
            end

            def destroy
                if @user.destroy
                    render json: @user
                else
                    render json: @user.errors
                end
            end
        

            private

            def set_user
                @user = User.find(params[:id])
            end

            def user_params_create
                params.permit(:name, :email, :password, :password_confirmation, :photo_path)
            end

            def user_params
                params.permit(:name, :email)
            end

        end

    end
end
