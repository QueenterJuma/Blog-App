Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  
  resources :users, only: [:show] do
    resources :posts, only: [:index, :show, :destroy]
  end

  resources :posts, only: [:new, :create] do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:create]
    end
end
