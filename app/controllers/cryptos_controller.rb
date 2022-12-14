class CryptosController < ApplicationController
  def new
    @crypto = Crypto.new
    @wallet = Wallet.find(params[:wallet_id])
  end

  def create
    require 'net/http'
    require 'json'
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @search_cryptos = JSON.parse(@response)

    @crypto = Crypto.new(crypto_params)
    @wallet = Wallet.find(params[:wallet_id])
    @crypto.wallet = @wallet

    @search_cryptos.each do |search_crypto|
      if @crypto.name == search_crypto["name"]
         @crypto.price = search_crypto["current_price"]
      end
    end

    if @crypto.save
      redirect_to wallet_path(@wallet)
    else
      render :new
    end
  end

  private

  def crypto_params
    params.require(:crypto).permit(:name, :address, :number, :wallet_id)
  end
end
