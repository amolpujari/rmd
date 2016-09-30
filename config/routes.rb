Rails.application.routes.draw do
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  ActiveAdmin.routes(self)
  root 'products#index'
end
