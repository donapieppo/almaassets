Rails.application.routes.draw do
  resources :goods

  resources :cathegories do 
    resources :goods
  end

  root to: 'goods#index'
end
