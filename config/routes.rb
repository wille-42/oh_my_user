Rails.application.routes.draw do
  namespace :admin do
    root to: 'dashboard#index', as: :dashboard

    get :login, to: 'sessions#new', as: :login
    post :login, to: 'sessions#create'
    get :logout, to: 'sessions#destroy', as: :logout

    resources :staffs, except: [:show]
    resources :roles
  end
end
