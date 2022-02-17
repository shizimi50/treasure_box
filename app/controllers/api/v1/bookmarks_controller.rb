module Api
    module V1
        class BookmarksController < ApplicationController
            before_action :require_login
        
            def create
                # 他人のFavoriteにのみBookmarkが表示される（フロント側で対応）
        
                favorite = Favorite.find(params[:favorite_id])
                current_user.bookmark(favorite)
                render json: { status: 'success', data: favorite, message: '他人のFavoriteをブックマーク'}

                # 元のコード favorite = current_user.favorites.build(favorite_id: params[:favorite_id])
                # 元のコード favorite.save!        
            end
        
            def destroy
                favorite = current_user.bookmarks.find(params[:id]).favorite
                current_user.unbookmark(favorite)
                # 元々のコード current_user.bookmarks.find(params[:id]).destroy!
                render json: { status: 'success', message: 'unbookmarked'}
            end

            def my_bookmarks
                favorite = current_user.bookmarks
                render json: { status: 'success', message: 'my bookmark', data: favorite}
            end
                    

            
        end
    end
end