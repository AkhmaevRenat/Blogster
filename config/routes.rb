# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profile', to: 'users#profile'
  devise_for :users
  resources :users do
    collection do
        match 'search' => 'users#search', via: [:get, :post], as: :search
    end
  end
  resources :articles do
    collection do
      match 'search' => 'articles#search', via: [:get, :post], as: :search
    end
    member do
      get 'like' => 'likes#add_like'
    end
    resources :comments do
      member do
        get 'like' => 'likes#add_like'
      end
    end
  end
  root 'articles#index'
end
