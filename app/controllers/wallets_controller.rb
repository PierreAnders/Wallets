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
    @wallet.save
    redirect_to wallet_path(@wallet)
  end

  def show
    @wallet = Wallet.find(params[:id])
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
