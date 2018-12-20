Rails.application.routes.draw do
  resources :goods do
    get 'find', on: :collection
  end

  resources :categories do 
    resources :goods
  end

  resources :organizations
  resources :locations

  root to: 'goods#index'
end
