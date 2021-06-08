Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :purchases, only: [:create, :index]
    resources :comments, only:[:create]
  end
  resources :cards, only: [:new, :create]
end