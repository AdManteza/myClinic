Rails.application.routes.draw do
  resources :sites
  resources :accounts
  root 'sites#show'

  get 'sites/index'
  get 'sites/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
