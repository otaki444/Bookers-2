Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'tops#home'
  resources :users, only: [:show, :edit, :update, :index] do
  	resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower'
    get 'followers' => 'relationships#followed'
  end
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
  get "home/about"  => "tops#about"
  get "/search" => "search#search"

end
