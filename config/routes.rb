Rails.application.routes.draw do
  root 'sites#index'

  resources :appointments
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'sites/index'
  get 'sites/show'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
