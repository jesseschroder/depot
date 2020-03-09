Rails.application.routes.draw do
  resources :orders
  get 'admin', to: 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products do
    get :who_bought, on: :member
  end

  ## API

  get 'api/products', to: 'product_api#index'
  get 'api/products/:id', to: 'product_api#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
