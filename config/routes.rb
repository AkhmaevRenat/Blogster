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
    resources :comments
  end

  get 'likes/add', to: 'likes#like_management'
  root 'articles#index'
end