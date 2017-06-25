Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'home#index'

resources :users, only: %i(index show new create)

resources :sessions, only: %i(new create destroy)

end
