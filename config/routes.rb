Rails.application.routes.draw do
	mount ActionCable.server => '/cable'
  resources :messages, only: [:create]
  resources :rooms, param: :slug, only: [:index, :create, :show, :new]
  # resources :users
  root "welcome#home"
  
  get '/signup', to: "registrations#new"
  post '/signup', to: "registrations#create"

  get 'login', to: "sessions#new"
  post '/login', to: "sessions#create" 
  delete '/logout', to: "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #api
  namespace :api do
    namespace :v1 do
      resources :rooms, param: :slug, only: [:index, :create, :show]
      resources :sessions, only: [:create]
    end
  end
end
