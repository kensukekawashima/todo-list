Rails.application.routes.draw do
  root 'statics#index'
  get '/about', to: 'statics#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :followings, :followers
    end
  end
  resources :tasks, only: [:index, :show, :create, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
