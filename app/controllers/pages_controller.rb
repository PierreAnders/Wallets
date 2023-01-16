class PagesController < ApplicationController
  require 'net/http'
  require 'json'

  def home
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @coins = JSON.parse(@response)
  end

  def portfolio
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @search_cryptos = JSON.parse(@response)
    @wallets = Wallet.where(user: current_user)

    @portfolio_value = 0
    @number_of_crypto = 0
    @portfolio_value_change_24h = 0
  end

  def transaction
  end

  def nft
    @url = "https://api.rarible.org/v0.1/items/byOwner/?owner=ETHEREUM:#{params[:query]}"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @nfts = JSON.parse(@response)
  end
end
