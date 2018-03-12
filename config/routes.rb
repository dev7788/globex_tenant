Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users do
    post :invite, :on => :collection
  end
end
