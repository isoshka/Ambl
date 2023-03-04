Rails.application.routes.draw do
  get 'places/new'
  get 'interests/new'
  get 'bookmarks/new'
  get 'users/new'
  devise_for :users
    # registrations: 'users/registrations',
    # get 'settings' => 'users/sessions#settings'

  devise_scope :user do
    get 'settings' => 'users/registrations#settings'
  end
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/settings", to: "users#settings"

  resources :bookmarks, only: [:create] do
    collection do
      get :nearby
    end
  end

  resources :interests, only: [:index]

  resources :bookmarks, only: [:new, :create, :index, :destroy]

  resources :notifications, only: [:create, :show]

  resources :places, only: [:show, :index] do
    member do
      get :directions
      post 'toggle_favorite', to: "places#toggle_favorite"

    end
  end

  # resources :places, only: :index do
  #   member do
  #     post 'toggle_favorite', to: "places#toggle_favorite"
  #   end
  # end


end
