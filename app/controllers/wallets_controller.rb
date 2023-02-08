class WalletsController < ApplicationController
  before_action :search_for_crypto

  def index
    @wallets = Wallet.where(user: current_user)
  end

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.new(wallet_params)
    @wallet.user = current_user
    if @wallet.save
      redirect_to wallet_path(@wallet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @crypto = Crypto.new
    @wallet = Wallet.find(params[:id])

    @wallet_value = 0
    @wallet_value_change_24h = 0
  end

  def edit
    @wallet = Wallet.find(params[:id])
  end

  def update
    @wallet = Wallet.find(params[:id])
    @wallet.update!(wallet_params)
    redirect_to wallet_path(@wallet)
  end

  def destroy
    @wallet = Wallet.find(params[:id])
    @wallet.destroy
    redirect_to wallets_path, status: :see_other, notice: "You have well deleted this wallet"
  end

  private

  def wallet_params
    params.require(:wallet).permit(:name, :category)
  end

  def search_for_crypto
    require 'net/http'
    require 'json'

    @url1 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1'
    @uri1 = URI(@url1)
    @response1 = Net::HTTP.get(@uri1)
    @search_cryptos1 = JSON.parse(@response1)

    @url2 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=2'
    @uri2 = URI(@url2)
    @response2 = Net::HTTP.get(@uri2)
    @search_cryptos2 = JSON.parse(@response2)

    @search_cryptos = @search_cryptos1 + @search_cryptos2
  end
end
