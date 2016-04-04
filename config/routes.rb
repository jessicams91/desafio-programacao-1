Rails.application.routes.draw do
  get 'order/index'

  get 'order/edit'

  root 'home#index'
end
