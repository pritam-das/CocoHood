Rails.application.routes.draw do
  resources :plans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'home#index'

resources :users

resources :personal_messages, only: [:new, :create]
resources :conversations, only: [:index, :show]

resources :sessions, only: %i(new create destroy)

end
