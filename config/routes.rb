Rails.application.routes.draw do
  root 'order#index'

  resources :orders, only:[:index, :show, :destroy] do
    collection { post :import }
  end
end
