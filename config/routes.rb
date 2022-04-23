Rails.application.routes.draw do
  resources :euro_exchange_rates
  root 'application#hello'
end
