Rails.application.routes.draw do
  begin
    mount Ckeditor::Engine => '/ckeditor'

    devise_for :admins,
      controllers: {
        sessions: 'latte/devise/sessions',
        passwords: 'latte/devise/passwords'
      },
      path: 'latte/auth',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout'
      }

    namespace :latte do

      scope '(:locale)', locale: /#{LatteConfig[:languages].join('|')}/ do

        root 'dashboard#index'

        resources :admins
        resources :app_settings
        resources :articles
        resources :authors
        resources :banners
        resources :brands
        resources :categories
        resources :datafiles
        resources :event_prices
        resources :events
        resources :images
        resources :pages
        resources :products
        resources :recipes
        resources :recipes_categories
        resources :tags, only: [:index]
        resources :users
        resources :videos
      end
    end
  rescue
    nil
  end
end
