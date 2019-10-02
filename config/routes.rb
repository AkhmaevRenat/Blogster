# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profile', to: 'users#profile'
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
  get '/403', to: 'errors#forbidden'
  devise_for :users
  get 'like/add_like' => 'likes#create', via: [:get]
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
  root 'articles#index'
end
