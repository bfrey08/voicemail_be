Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :letters, only: [:create, :destroy]
      resources :sessions, only: [:create]
      resources :users, only: [:create, :update, :show] do
        resources :representatives, only: [:index]
        resources :letters, only: [:index]
      end
    end
  end

end
