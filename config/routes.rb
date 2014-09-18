Rails.application.routes.draw do
  root 'plays#index'

  resources :plays, only: :index do
    resources :roles, only: :index
  end
end
