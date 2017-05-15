Rails.application.routes.draw do
	mount ActionCable.server => '/cable'
  resources :messages
  resources :rooms, param: :slug
  # resources :users
  root "welcome#home"
  
  get '/signup', to: "registrations#new"
  post '/signup', to: "registrations#create"

  get 'login', to: "sessions#new"
  post '/login', to: "sessions#create" 
  delete '/logout', to: "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
