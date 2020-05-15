Rails.application.routes.draw do
  # get 'home', to: 'converter#index'
  # get 'to_num', to: 'converter#number'
  resources :converter
  root to: 'converter#index'
end
