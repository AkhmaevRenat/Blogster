Rails.application.routes.draw do
  get 'profile', to: 'users#profile'
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
  get '/403', to: 'errors#forbidden'
  devise_for :users
  resources :users
  resources :articles do
    resources :comments
  end
  root 'welcome#index'
end
