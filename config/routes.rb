Rails.application.routes.draw do
  devise_for :users

  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    #瀏覽所有餐廳的最新動態
    collection do
      get :feeds
      get :ranking
    end

    #瀏覽個別餐廳的 Dashboard
    member do
      get :dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end
  end
  resources :categories, only: :show

  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end
