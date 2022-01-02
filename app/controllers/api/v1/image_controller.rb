module Api
  module V1
    class ImageController < ApplicationController
      before_action :require_login
      before_action :set_user, :image_params

      def update
        if @user.update(image_params)
            render json: @user
        else
            render json: @user.errors
        end
      end

      def destroy
        @user.remove_photo_path!
        @user.save
        render json: @user
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def image_params
        params.permit(:photo_path)
      end

    end
  end
end