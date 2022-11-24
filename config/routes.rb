Rails.application.routes.draw do
  mount DmUniboCommon::Engine => "/dm_unibo_common"

  get '/choose_organization', to: "home#choose_organization"

  scope ":__org__" do
    resources :users do
      resources :goods
      resources :good_requests
    end
    resources :documents
    resources :main_agreements do
      resources :documents
    end

    resources :goods do
      get  'find', on: :collection
      post 'find', on: :collection

      get  'new_unload', on: :member
      post 'unload', on: :member
      patch 'unload', on: :member

      get  'new_confirm',   on: :member
      post 'confirm',       on: :member
      get  'new_unconfirm', on: :member
      post 'unconfirm',     on: :member
      get  'ask_category',  on: :member
      post 'set_category',  on: :member

      get  'print', on: :collection
    end

    resources :good_requests do
      put :approve, on: :member
      get :print, on: :member
    end

    resources :uploads

    resources :categories do 
      resources :goods
      resources :good_requests
    end

    resources :locations

    resources :bookings 

    # resources :servers do
    #   resources :bookings
    # end

    get '/hg/:id', to: 'bookings#hg', as: :hg, defaults: { format: 'json' }

    get '/', to: 'home#index', as: 'current_organization_root'
  end

  root to: 'home#index'
end
