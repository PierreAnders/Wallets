class WalletsController < ApplicationController

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
    @wallet = Wallet.find(params[:id])
    require 'net/http'
    require 'json'
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @search_cryptos = JSON.parse(@response)
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
    redirect_to wallets_path, status: :see_other
  end

  private

  def wallet_params
    params.require(:wallet).permit(:name, :category)
  end

end
