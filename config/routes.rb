Rails.application.routes.draw do
  root "beneficiarios#index"

  resources :beneficiarios, only: [:index]
end
