class TransfersController < ApplicationController
  def create
    # Get form values
    to = params[:to]
    amount = params[:amount].to_f

    # Your code to process the transfer
    # ...

    # Redirect to the transfers history page
    redirect_to transfers_path
  end
end
