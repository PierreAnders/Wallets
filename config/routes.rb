Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/transaction", to: "pages#transaction"
  get "/portfolio", to: "pages#portfolio"
  resources :wallets do
    resources :cryptos
  end
end
