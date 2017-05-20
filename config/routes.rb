Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'restaurants#index'

  get '/restaurants' => 'restaurants#index'
  get '/restaurants/:id' => 'restaurants#show'
  get '/reservations' => 'reservations#index'
  get '/reservations/canceled' => 'reservations#canceled'
  delete '/reservations/:id' => 'reservations#delete'
  post '/reservations' => 'reservations#create'
end
