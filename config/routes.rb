Rails.application.routes.draw do
  root 'client/sites#show' #temp for now

  namespace :admin do
    resources :appointments
    resources :users
  end

  namespace :client do
    resources :users, only: [:new, :show]
    resources :sites
  end

  resources :sessions, only: [:new, :create, :destroy]

  # get 'sites/index'
  # get 'sites/show'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
