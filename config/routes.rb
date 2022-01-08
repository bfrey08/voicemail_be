Rails.application.routes.draw do
  post '/letters', to: 'letters#create'

  resources :users, only: [:create, :update, :show]
end
