Rails.application.routes.draw do
  resources :goods

  resources :cathegories do 
    resources :goods
  end

  resources :organizations
  resources :locations

  root to: 'goods#index'
end
