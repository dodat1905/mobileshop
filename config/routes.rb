Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :carts, only: %i(show destroy)
    resources :line_items
    post "/increase/:id", to: "line_items#index", as: :quantity
    devise_for :users, controllers: { registrations: "registrations" }
    resources :users, only: %i(show)
    resources :brands, only: %i(show index)
    resources :products, only: %i(show index)
    root "static_pages#index"
    resources :orders, only: %i(new create show)
    post "orders/new", to: "orders#create"
    get "admin", to: "admin#index"
    namespace :admin do
      resources :products
      resources :brands
      resources :orders
      resources :users
    end
  end
end
