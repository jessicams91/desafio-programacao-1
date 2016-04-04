Rails.application.routes.draw do
  root 'home#index'

  resources :orders, only:[:index, :edit, :update] do
    collection { post :import }
  end
end
