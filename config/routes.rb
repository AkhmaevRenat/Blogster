# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  default_url_options :host => "localhost:3000"
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_scope :user do
    authenticated :user do
      root 'articles#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :users do
    get 'follow', to: 'followings#create'
    get 'unfollow', to: 'followings#destroy'
    collection do
        match 'search' => 'users#search', via: [:get, :post], as: :search
    end
  end
  resources :articles do
    collection do
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end
    member do
      get :retweet
    end
    resources :comments
  end
  get 'profile', to: 'users#profile'
  post 'profile/edit', to: 'users#edit'
  get 'likes/add', to: 'likes#like'
  get 'likes/remove', to: 'likes#unlike'
end