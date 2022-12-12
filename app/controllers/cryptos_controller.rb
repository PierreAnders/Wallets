class CryptosController < ApplicationController
  # before_action :set_crypto, only: %i[ show edit update destroy ]

  def index
    @cryptos = Crypto.all
    require 'net/http'
    require 'json'
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @search_crypto = JSON.parse(@response)
  end

  def new
    @crypto = Crypto.new
    @wallet = Wallet.find(params[:wallet_id])
  end

  # def create
  #   @crypto = Crypto.new(crypto_params)
  #   @wallet = Wallet.find(params[:wallet_id])
  #   @crypto.wallet = @wallet

  #   respond_to do |format|
  #     if @crypto.save
  #       format.html { redirect_to crypto_url(@crypto), notice: "Crypto was successfully created." }
  #       format.json { render :show, status: :created, location: @crypto }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @crypto.errors, status: :unprocessable_entity }
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

  private

  def crypto_params
    params.require(:crypto).permit(:name, :address, :number, :wallet_id)
  end
end




  # private

  # def set_crypto
  #   @crypto = Crypto.find(params[:id])
  # end

  # def crypto_params
  #   params.require(:crypto).permit(:name, :address, :number, :wallet_id)
  # end
