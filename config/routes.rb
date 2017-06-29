Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

root 'home#index'

resources :users do
    resources :conversations
end

resources :sessions, only: %i(new create destroy)

end
