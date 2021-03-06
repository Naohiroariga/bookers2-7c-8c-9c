Rails.application.routes.draw do
  get 'groups/new'
  get 'groups/edit'
  get 'new/edit'
  get 'chats/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]

  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :groups, only: [:new, :index, :show, :edit, :create, :update]

  get "search" => "searches#search"

  resources :chats, only: [:show, :create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end