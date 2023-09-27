Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index] 
      post '/registration', to: 'users#create'
      resources :sessions do
        post '/login', to: 'sessions#create'
      end
      resources :road_trip, only: [:create]
    end
  end
end