module Api
    module V1
        class FavoritesController < ApplicationController
            before_action :favorite_params, only:[:create, :update, :destroy]
            before_action :set_favorite, only:[:update, :destroy]
            
            def index
                favorites = Favorite.all
                render json: favorites                
            end

            def dashboard
                favorites = Favorite.where(user_id: current_user.id) #MyFavorite
                # Others Latest Favorite
                # Favorite Ranking
            end

            def create
                favorite = Favorite.new(favorite_params)
                if favorite.save
                    render json: favorite
                else
                    render json: favorite.errors.full_messages
                end
            end

            def update
                if @favorite.update(favorite_params)
                    render json: @favorite
                else
                    render json: @favorite.errors
                end
            end

            def destroy
                if @favorite.destroy
                    render json: @favorite
                else
                    render json: @favorite.errors
                end
            end

            def search
            end

            private
            
            def favorite_params
                params.permit(:theme, :user_id, :image_path, :deleted_at)
            end

            def set_favorite
                @favorite = Favorite.find(params[:id])
            end
        end
    end
end

