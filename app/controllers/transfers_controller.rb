class TransfersController < ApplicationController
  require 'httparty'

  def new
  end

  def index
    @wallets = Wallet.where(user: current_user)

    # Get the history of all transactions of an ethereum address
    response = HTTParty.get("https://api.etherscan.io/api?module=account&action=txlist&address=#{params[:query]}&startblock=0&endblock=99999999&sort=asc&apikey=#{ENV['API_KEY']}")
    @transactions = response.parsed_response['result']

    # Create a collection from all the ethereum addresses of the user
    @address_option = []
    @wallets.each do |wallet|
      wallet.cryptos.each do |crypto|
        @address_option.push(crypto.address) if crypto.name == "Ethereum"
      end
    end
  end
end
