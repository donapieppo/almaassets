Rails.application.routes.draw do
  resources :goods do
    get 'find', on: :collection
    get 'unload', on: :member

    get  'new_confirm',   on: :member
    post 'confirm',       on: :member
    get  'new_unconfirm', on: :member
    post 'unconfirm',     on: :member
  end

  resources :users 

  resources :categories do 
    resources :goods
  end

  resources :organizations
  resources :locations

  root to: 'goods#index'
end
