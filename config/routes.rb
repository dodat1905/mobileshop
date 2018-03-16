Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :carts, only: %i(show destroy)
    resources :line_items, only: %i(index create destroy)
    post "/increase/:id", to: "line_items#index", as: :quantity
    devise_for :users, controllers: { registrations: "registrations" }
    resources :users
    get "/admin/brands", to: "admin#brand"
    get "/admin/products", to: "admin#product"
    get "admin/users", to: "users#index"
    get "admin/products/new", to: "products#new"
    get "admin/brands/new", to: "brands#new"
    resources :brands
    resources :products
    resources :admin
    root "static_pages#home"
  end
end
