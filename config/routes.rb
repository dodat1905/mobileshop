Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :carts, only: %i(show destroy)
    resources :line_items
    post "/increase/:id", to: "line_items#index", as: :quantity
    devise_for :users, controllers: { registrations: "registrations" }
    resources :users, only: %i(show)
    resources :brands, only: %i(show index)
    resources :products, only: %i(show index)
    namespace :admin do
      resources :products
      resources :brands
    end
    root "static_pages#home"
    resources :orders
    post "orders/new", to: "orders#create"
  end
end
