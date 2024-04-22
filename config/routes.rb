Rails.application.routes.draw do
  get 'homes/top'
  get '/home/about', to: 'homes#about'
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy, :new]
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy, :new]
  
end