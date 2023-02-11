Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/settings", to: "user#settings"
  resources :users, only: :update

  resources :interests, only: [:index]

  resources :bookmarks, only: [:create]

  resources :notifications, only: [:create, :show]

  resources :places, only: [] do
    member do
      get :directions
    end
  end
end
