module Api
    module V1
        class FavoritesController < ApplicationController
            before_action :favorite_params, only:[:create, :update, :destroy]
            before_action :set_favorite, only:[:update, :destroy]
            
            def index
                favorites = Favorite.all
                render json: favorites
                # render json: favorites, serializer: FavoriteSerializer
            end

            def dashboard
                myfavorites = Favorite.where(user_id: current_user.id).limit(3) #MyFavorite
                othersfavorites = Favorite.where.not(user_id: current_user.id).order(updated_at: :desc).limit(3) #Others Latest Favorite
                rankingfavorites = FavoriteData.find(Like.group(:favorite_data_id).order('count(favorite_data_id) desc').limit(3).pluck(:favorite_data_id)) # Favorite Ranking

                render json: {data: {my_favorite: myfavorites, lastest_favorite: othersfavorites, favorite_ranking: rankingfavorites }}

            end

            def create
                favorite = current_user.favorites.build(favorite_params)
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

