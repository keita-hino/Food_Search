Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  # get 'users/login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'restaurants#index'
  resources :restaurants
  post '/callback' => 'linebot#callback'
  get '/index' => 'linebot#index'
  # root 'users#index'
end
