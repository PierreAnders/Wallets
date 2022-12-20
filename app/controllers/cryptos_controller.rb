class CryptosController < ApplicationController
  def new
    @crypto = Crypto.new
    @wallet = Wallet.find(params[:wallet_id])
  end

  # def create
  #   require 'net/http'
  #   require 'json'
  #   @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250'
  #   @uri = URI(@url)
  #   @response = Net::HTTP.get(@uri)
  #   @search_cryptos = JSON.parse(@response)

  #   @crypto = Crypto.new(crypto_params)
  #   @wallet = Wallet.find(params[:wallet_id])
  #   @crypto.wallet = @wallet

  #   @search_cryptos.each do |search_crypto|
  #     if search_crypto.find[@crypto.name]
  #       @crypto.save
  #       redirect_to wallet_path(@wallet)
  #     else
  #       raise
  #     end
  #   end
  # end

  def create
    @crypto = Crypto.new(crypto_params)
    @wallet = Wallet.find(params[:wallet_id])
    @crypto.wallet = @wallet
    if @crypto.save
      redirect_to wallet_path(@wallet)
    else
      render :new
    end
  end

  def edit
    @crypto = Crypto.find(params[:id])
    @wallet = Wallet.find(params[:wallet_id])
  end

  def update
    @crypto = Crypto.find(params[:id])
    @wallet = Wallet.find(params[:wallet_id])
    @crypto.update!(crypto__update_params)
    redirect_to wallet_path(@wallet)
  end

  def destroy
    @crypto = Crypto.find(params[:id])
    @wallet = Wallet.find(params[:wallet_id])
    @crypto.destroy
    redirect_to wallet_path(@wallet)
  end

  private

  def crypto_params
    params.require(:crypto).permit(:name, :address, :number, :wallet_id)
  end

  def crypto__update_params
    params.require(:crypto).permit(:address, :number, :wallet_id)
  end
end
