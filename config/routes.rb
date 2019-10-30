# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  get 'profile', to: 'users#profile'
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
    collection do
        match 'search' => 'users#search', via: [:get, :post], as: :search
    end
    resources :subscribtions
  end
  resources :articles do
    collection do
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end
    resources :comments
  end
  get 'likes/add', to: 'likes#like_management'
end