Rails.application.routes.draw do
  mount API => '/'
  root 'standups#index'
  resources :standups, only: :index
  resources :settings, only: [:index, :update, :create]
end
