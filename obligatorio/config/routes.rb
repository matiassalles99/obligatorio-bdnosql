Rails.application.routes.draw do
  root "static_pages#home"

  get "/home", to: "static_pages#home"

  resources :vehicle_telemetries, only: %i[index new create]
  resources :products, only: %i[index new create]
end
