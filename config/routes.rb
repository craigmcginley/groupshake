Rails.application.routes.draw do
  resources :plays, only: :index do
    resources :roles, only: :index
  end
end
