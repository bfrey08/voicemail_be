Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :letters, only: %i[create destroy]
      post "letters/preview", to: "letters#preview"
      resources :users, only: %i[create update show] do
        resources :representatives, only: [:index]
        resources :letters, only: [:index]
        post '/letters', to: "letters#send_letter"
      end
    end
  end
end
