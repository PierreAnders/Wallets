class PagesController < ApplicationController
  def home
    require 'net/http'
    require 'json'
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @coins = JSON.parse(@response)
  end

  def portfolio
    require 'net/http'
    require 'json'
    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @search_cryptos = JSON.parse(@response)
    @wallets = Wallet.where(user: current_user)
  end

  def transaction
  end

  def nft
  end

end
