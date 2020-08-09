Rails.application.routes.draw do
  root to: 'home#top'
  get 'home/about'
  devise_for :users
  resources :users do
    member do
      get 'users/follows'
      get 'users/followers'
    end
  end
  resources :books do
  	resources :favorites,only: [:create,:destroy]
  	resources :book_comments,only: [:create,:destroy]
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

end