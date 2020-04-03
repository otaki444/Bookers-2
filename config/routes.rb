Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'tops#home'
  resources :users, only: [:show, :edit, :update, :index]
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resource :book_comments, only: [:create]
  	resources :book_comments, only: [:destroy]

  end
  get  "home/about"  => "tops#about"
end
