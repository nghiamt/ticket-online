Rails.application.routes.draw do
  resources :orders
  resources :order_lines
  resources :places do
    resources :tickets
  end
  root 'dashboard#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
