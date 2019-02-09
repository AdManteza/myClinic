Rails.application.routes.draw do
  # each client will have a different homepage
  root 'client/sites#show'

  namespace :admin do
    resources :sessions, only: [:create, :destroy]
    resources :appointments
    resources :users
  end

  namespace :client do
    resources :sessions, only: [:create, :destroy]
    resources :users, only: [:new, :show]
    resources :sites, only: [:show]
  end

  get 'admin_logout', to: 'admin/sessions#destroy', as: 'admin_logout'
  get 'admin_dashboard', to: 'admin/admin#dashboard', as: 'admin_dashboard'
  post 'admin_login', to: 'admin/sessions#create', as: 'admin_login'

  get 'user_signup', to: 'client/users#new', as: 'user_signup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
