Rails.application.routes.draw do
  devise_for :users 
  
  resources :projects do
    resources :comments
  end

  # Defines the root path route ("/")
  root "projects#index"
end
