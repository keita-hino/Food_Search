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
  post 'restaurants/share' => 'restaurants#share'
  namespace 'api' do
    namespace 'v1' do
      resources :restaurants do
        collection do
          post :share
        end
      end
    end
  end
  # root 'users#index'
  # resources :location
end
