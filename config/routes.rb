Rails.application.routes.draw do
  get 'memes/index'
  get 'memes/show'
  get 'memes/new'
  get 'memes/create'
  get 'memes/edit'
  get 'memes/update'
  get 'memes/destroy'
  devise_for :users
  root to: 'pages#home'
  get 'style-guide', to: 'pages#style_guide'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # users can't edit categories
  resources :categories, except: [:edit, :update]
  # destroy doesn't need to be nested
  resources :collections, except: [:show, :index]

  # routes for users note handle by devise
  resources :users, only: [:index, :show] do
    # nested collections routes
    resources :collections, only: [:show]
  end

  # need all routes for memes, not nested
  resources :memes do
    # nest likes and comments routes in meme (always belong to)
    resources :likes, only: [:new, :create, :destroy]
    resources :comments, except: [:index]
  end

end
