Rails.application.routes.draw do
  get 'welcome/index'
  get 'articles/user_page'
  devise_for :users
  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
