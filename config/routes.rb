Rails.application.routes.draw do
  root 'statics#index'
  get '/about', to: 'statics#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :tasks, only: [:index, :create, :update, :destroy]
  resources :users do
    resources :tasks, only: [:create,:update,:destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
