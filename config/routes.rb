Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/letters', to: 'letters#create'
    end
  end
end
