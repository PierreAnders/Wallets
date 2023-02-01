class PagesController < ApplicationController
  require 'net/http'
  require 'json'

  def home

    @url1 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1'
    @uri1 = URI(@url1)
    @response1 = Net::HTTP.get(@uri1)
    @coins1 = JSON.parse(@response1)

    @url2 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=2'
    @uri2 = URI(@url2)
    @response2 = Net::HTTP.get(@uri2)
    @coins2 = JSON.parse(@response2)

    @url3 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=3'
    @uri3 = URI(@url3)
    @response3 = Net::HTTP.get(@uri3)
    @coins3 = JSON.parse(@response3)

    @url4 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=4'
    @uri4 = URI(@url4)
    @response4 = Net::HTTP.get(@uri4)
    @coins4 = JSON.parse(@response4)

    @coins = @coins1 + @coins2 + @coins3 + @coins4
  end

  def portfolio

    @url1 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1'
    @uri1 = URI(@url1)
    @response1 = Net::HTTP.get(@uri1)
    @search_cryptos1 = JSON.parse(@response1)

    @url2 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=2'
    @uri2 = URI(@url2)
    @response2 = Net::HTTP.get(@uri2)
    @search_cryptos2 = JSON.parse(@response2)

    @url3 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=3'
    @uri3 = URI(@url3)
    @response3 = Net::HTTP.get(@uri3)
    @search_cryptos3 = JSON.parse(@response3)

    @url4 = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=4'
    @uri4 = URI(@url4)
    @response4 = Net::HTTP.get(@uri4)
    @search_cryptos4 = JSON.parse(@response4)

    @search_cryptos = @search_cryptos1 + @search_cryptos2 + @search_cryptos3 + @search_cryptos4

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

    @wallets = Wallet.where(user: current_user)
  end
end
