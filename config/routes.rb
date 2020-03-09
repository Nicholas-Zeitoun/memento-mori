Rails.application.routes.draw do
  devise_for :users
  root to: 'memes#index'
  get 'dashboard-template', to: 'pages#dashboard_template'
  get 'style-guide', to: 'pages#style_guide'
  get 'dashboard-template', to: 'pages#dashboard_template'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # users can't edit categories, can't create categories without creating a meme
  resources :categories, except: [:new, :create, :edit, :update] do
    member do
      post :follow
      post :unfollow
    end
  end
  # destroy doesn't need to be nested
  resources :collections, except: [:show, :index] do
    member do
      post :follow
      post :unfollow
    end
  end

  # routes for users note handle by devise
  resources :users, only: [:index, :show] do
    # member routes for user followings
    member do
      post :follow
      post :unfollow
    end
    # nested collections routes
    resources :collections, only: [:show]
  end

  # need all routes for memes, not nested
  resources :memes do
    # nest likes and comments routes in meme (always belong to)
    resources :likes, only: [:new, :create, :destroy]
    resources :categories, only: [:new, :create]
    resources :comments, except: [:index]
    resources :collects, only: [:new, :create, :destroy]
  end

end
