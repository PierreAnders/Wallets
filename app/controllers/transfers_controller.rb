class TransfersController < ApplicationController
  require 'httparty'

  def new
  end

  def index
    @wallets = Wallet.where(user: current_user)
    response = HTTParty.get("https://api.etherscan.io/api?module=account&action=txlist&address=#{params[:query]}&startblock=0&endblock=99999999&sort=asc&apikey=BBEVJRYJKR3QDT95XU2QM686YEGXM7XNN3")
    @transactions = response.parsed_response['result']
    @address_option = []
    @wallets.each do |wallet|
      wallet.cryptos.each do |crypto|
        @address_option.push(crypto.address) if crypto.name == "Ethereum"
      end
    end
  end
end
