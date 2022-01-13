Rails.application.routes.draw do

  resources :users
  resources :user_time
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'sessions/new'
  delete 'sessions/destroy' 
  post "sessions/create"
  
  post '/userTime' => "user_time#create"
  get '/average_time/:id' => "user_time#average_time"
  get '/average_distance/:id' => "user_time#average_distance"
  get '/userTime' => "user_time#index"
  get '/user_time_show/:id'=>"user_time#show"
  get '/userTimeUser/:id'=>"user_time#showuser" 
  put '/userTime/:id'=>"user_time#update"
  delete '/userTime/:id' =>"user_time#destroy"

end
