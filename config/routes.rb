Rails.application.routes.draw do
  resources :goods

  resources :categories do 
    resources :goods
  end

  resources :organizations
  resources :locations

  root to: 'goods#index'
end
