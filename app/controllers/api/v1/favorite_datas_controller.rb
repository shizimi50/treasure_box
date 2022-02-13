module Api
    module V1
        class FavoriteDatasController < ApplicationController
            before_action :favorite_data_params, only:[:create, :update, :destroy]
            before_action :set_favorite_data, only:[:show, :update, :destroy]

            def search
                # sortkey = params[:sortkey] #ソートパラメータ
                q = params[:q] #検索パラメータ
                results = FavoriteData.where('title LIKE ? OR star LIKE ?', "%#{q}%", "%#{q}%");
                if q.blank? #検キーが入力されていない場合
                    render json: { status: 200, message: "success", data: { favorite_data: results }}  
                else 
                    render json: { status: 200, message: "success", data: { favorite_data: results.order(sortkey) }}  
                end
            end
            
            def index
                favorite_datas = FavoriteData.where(user_id: current_user.id)
                render json: favorite_datas
            end
            

            def show
                render json: @favorite_data
            end

            def create
                favorite_data = FavoriteData.new(favorite_data_params)
                if favorite_data.save
                    render json: favorite_data
                else
                    render json: favorite_data.errors.full_messages
                end
            end

            def update
                if @favorite_data.update(favorite_data_params)
                    render json: @favorite_data
                else
                    render json: @favorite_data.errors
                end
            end

            def destroy
                if @favorite_data.destroy
                    render json: @favorite_data
                else
                    render json: @favorite_data.errors
                end
            end

            private

            def favorite_data_params
                params.permit(:title, :image_path, :star, :deleted_at, :user_id, :favorite_id)
            end

            def set_favorite_data
                @favorite_data = FavoriteData.find(params[:id])
            end
        end
    end
end
