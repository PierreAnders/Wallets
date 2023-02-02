Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/portfolio", to: "pages#portfolio"
  get "/nft", to: "pages#nft"

  get "/transactions", to: "transactions#index"
  get "/transfers", to: "transfers#new"

  resources :wallets do
    resources :cryptos do
    end
  end
end
