Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users, :controllers => { invitations: 'devise/invitations' }
  resources :users do
    post :invite, :on => :collection
  end

end
