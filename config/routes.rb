Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      post '/letters/send', to: "letters#send_letter"
      resources :letters, only: %i[create destroy]
      post "letters/preview", to: "letters#preview"
      resources :users, only: %i[create update show] do
        resources :representatives, only: [:index]
        resources :letters, only: [:index]
      end
    end
  end
end
