Rails.application.routes.draw do
  resources :goods do
    get  'find', on: :collection
    post 'find', on: :collection
    get  'unload', on: :member

    get  'new_confirm',   on: :member
    post 'confirm',       on: :member
    get  'new_unconfirm', on: :member
    post 'unconfirm',     on: :member
    get  'ask_category', on: :member
    put  'set_category', on: :member

    get  'print', on: :collection
  end

  resources :uploads

  resources :users 

  resources :categories do 
    resources :goods
  end

  resources :organizations
  resources :locations

  root to: 'goods#index'
end
