Rails.application.routes.draw do
	mount ActionCable.server => '/cable'
  resources :messages
  resources :rooms, param: :slug
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
