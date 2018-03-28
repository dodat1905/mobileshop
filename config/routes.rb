Rails.application.routes.draw do
  resources :notifications, only: %i(index update)
  scope "(:locale)", locale: /en|vi/ do
    resources :carts, only: %i(show destroy)
    resources :line_items
    post "/increase/:id", to: "line_items#index", as: :quantity
    devise_for :users, controllers: { registrations: "registrations" }
    resources :users, only: %i(show) do
      resources :orders, only: :show
    end
    resources :brands, only: %i(show index)
    resources :products, only: %i(show index) do
      resources :comments
    end
    root "static_pages#index"
    post "orders/new", to: "orders#create"
    get "admin", to: "admin#index"
    namespace :admin do
      resources :products
      resources :brands
      resources :orders
      resources :users
      resources :static_pages, only: %i(index)
    end
    root "static_pages#index"
    resources :orders, except: :destroy
    post "orders/new", to: "orders#create"
    get :search, to: "searches#index"
    resources :products
    mount ActionCable.server, at: "/cable"
  end
end
