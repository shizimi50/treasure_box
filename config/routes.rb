Rails.application.routes.draw do
  get 'image/update'
  get 'image/destroy'
  # FrontEnd Rooting
  root to: 'dashboard#index'
  get 'login' => 'users#login'
  get 'signup' => 'users#signup'
  get 'resetpassword' => 'users#resetpassword'
  get 'dashboard' => 'dashboard#index'
  get 'sample' => 'users#sample'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # BackEnd Rooting
  namespace 'api' do
    namespace 'v1' do
      resources :users do
        collection do
          get :current_user,  to: 'sessions#index'
          post :login, to: 'sessions#create'
          delete :logout, to: 'sessions#destroy'
        end

        member do
          put :image, to: 'image#update'
          delete :image, to: 'image#destroy'
        end

        # collection do
        #   put :password, to: 'password_resets#create'
        #   post :password, to: 'password_resets#update'
        # end
      end

      resources :account_activations, only: [:edit]



      # resources :password_resets, only: %i[create update]

      resources :favorites, except: %i[show] do
        collection do
          post :search, to: 'favorite#search'
          get :dashboard, to: 'favorite#dashboard'
        end

        post :bookmarks, to: 'bookmarks#create'
        resources :favorite_datas
      end
    
      resources :bookmarks, only: %i[destroy] do
        collection do
          get :my_bookmarks, to: 'bookmarks#my_bookmarks'
        end
      end

      resources :likes, only: %i[create destroy] 

    end
  end
end
