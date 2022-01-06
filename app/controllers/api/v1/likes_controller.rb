module Api
    module V1
        class LikesController < ApplicationController
            before_action :require_login
            before_action :like_params, only: [:destroy]

            def create
                like = Like.create(user_id: @current_user.id, favorite_data_id: params[:favorite_data_id])
                render json: like
            end
            
            def destroy
                like = Like.find(params[:id])
                like.destroy
                render json: like
            end

            private

            def like_params
                params.permit(:user_id, :favorite_data_id)
            end


        end
    end
end