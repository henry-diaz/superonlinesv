Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, controllers: { sessions: 'auth/sessions', registrations: 'auth/registrations', passwords: 'auth/passwords', omniauth_callbacks: 'auth/omniauth_callbacks' }

  get "/admin" => redirect("/latte")

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :products
    end
  end
end
