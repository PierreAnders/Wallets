Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/portfolio", to: "pages#portfolio"
  resources :wallets do
    resources :cryptos
  end
end
