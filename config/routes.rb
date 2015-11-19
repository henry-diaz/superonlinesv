Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: { sessions: 'auth/sessions', registrations: 'auth/registrations', passwords: 'auth/passwords', omniauth_callbacks: 'auth/omniauth_callbacks' }

  get "/admin" => redirect("/latte")

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :products
      resources :carts, only: [:index] do
        collection do
          post 'add'
          post 'remove'
        end
      end
      resources :accounts, only: [] do
        collection do
          post 'signin'
          post 'login'
          post 'profile'
        end
      end
      post 'logout', to: 'accounts#logout'
    end
  end
end
