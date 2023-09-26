Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/products', to: 'products#index'
  get '/promotions', to: 'promotions#index'
  post '/cart', to: 'carts#create'
end
