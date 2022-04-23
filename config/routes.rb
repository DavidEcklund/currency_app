Rails.application.routes.draw do
  resources :euro_exchange_rates
  root 'euro_exchange_rates#index'
end
