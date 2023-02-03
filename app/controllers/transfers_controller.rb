class TransfersController < ApplicationController

  def new
  end

  def index
    @wallets = Wallet.where(user: current_user)
  end


end
