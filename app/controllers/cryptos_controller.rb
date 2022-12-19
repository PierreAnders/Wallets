class CryptosController < ApplicationController
  def new
    @crypto = Crypto.new
    @wallet = Wallet.find(params[:wallet_id])
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
    @crypto.wallet = @wallet
    @crypto.update!(crypto_params)
    redirect_to wallet_path(@wallet)
  end

  def destroy
    @crypto = Crypto.find(params[:id])
    @wallet = Wallet.find(params[:wallet_id])
    @crypto.wallet = @wallet
    @crypto.update!(crypto_params)
    redirect_to wallet_path(@wallet)
  end


  private

  def crypto_params
    params.require(:crypto).permit(:name, :address, :number, :wallet_id)
  end
end
