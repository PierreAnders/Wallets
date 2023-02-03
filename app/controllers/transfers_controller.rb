class TransfersController < ApplicationController

  def new

  end


  def create
    @transfer = Transfer.new(transfer_params)
    if @transfer.save
      redirect_to transfers_path
    else
      render :new
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(:to, :amount)
  end
end
