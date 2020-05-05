Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  post 'follow/:id' => 'relationships#follow', as: 'follow' #フォローする
  delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' #フォロー外す

  resources :users, only: [:show,:index,:edit,:update]
  get 'users/:id/followers' => 'relationships#followers', as: 'followers'
  get 'users/:id/followees' => 'relationships#followees', as: 'followees'

  # users/:id/followers
  # users/:id/followees

  resources :books do
		resource :favorites, only: [:create, :destroy]
  	resource :book_comments, only: [:create, :destroy]
  end
end
