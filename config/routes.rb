Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/letters', to: 'letters#create'
      get 'users/:id/representatives', to: 'representatives#index'
      resources :users, only: [:create, :update, :show]
    end
  end

end
