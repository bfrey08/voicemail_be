Rails.application.routes.draw do
  post '/letters', to: 'letters#create'
end
