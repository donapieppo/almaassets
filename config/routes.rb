Rails.application.routes.draw do
  resources :main_agreements

  resources :goods do
    get  'find', on: :collection
    post 'find', on: :collection
    get  'unload', on: :member

    get  'new_confirm',   on: :member
    post 'confirm',       on: :member
    get  'new_unconfirm', on: :member
    post 'unconfirm',     on: :member
    get  'ask_category',  on: :member
    put  'set_category',  on: :member

    get  'print', on: :collection
  end

  resources :good_requests do
    get :print, on: :member
  end

  resources :uploads

  resources :users 

  resources :categories do 
    resources :goods
    resources :good_requests
  end

  resources :organizations
  resources :locations

  resources :bookings 

  resources :servers do
    resources :bookings
  end

  get '/hg/:id', to: 'bookings#hg', as: :hg, defaults: { format: 'json' }

  root to: 'home#index'
end
