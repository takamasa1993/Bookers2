Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  root to: 'homes#top'
  get 'homes/about'
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:new, :create, :index, :show, :edit, :update]
  resources :users do
    resources :books
  end
end