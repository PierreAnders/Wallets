class CryptosController < ApplicationController
  def new
    @crypto = Crypto.new
    @wallet = Wallet.find(params[:wallet_id])
    @select_cryptos = CoinGeckoService.new.search_for_crypto.map { |coin| coin["name"] }.sort    
  end

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
    redirect_to wallet_path(@wallet), notice: "You have well deleted this asset"
  end

  private

  def crypto_params
    params.require(:crypto).permit(:account, :name, :address, :number, :wallet_id)
  end

  def crypto__update_params
    params.require(:crypto).permit(:account, :address, :number, :wallet_id)
  end
end
