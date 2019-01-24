Rails.application.routes.draw do
  resources :appointments
  root 'sites#index'

  get 'sites/index'
  get 'sites/show'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
