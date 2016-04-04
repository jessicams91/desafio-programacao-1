Rails.application.routes.draw do
  root 'home#index'

  resources :orders, only:[:index, :show] do
    collection { post :import }
  end
end
