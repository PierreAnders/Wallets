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

    @coins = @coins1 + @coins2
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

    @search_cryptos = @search_cryptos1 + @search_cryptos2

    @wallets = Wallet.where(user: current_user)

    @portfolio_value = 0
    @number_of_crypto = 0
    @portfolio_value_change_24h = 0
    @portfolio_rows = []

    @wallets.each do |wallet|

      wallet.cryptos.sort_by(&:name).each do |crypto|
        @search_crypto = @search_cryptos.find { |search_crypto| search_crypto["name"] == crypto.name }
        @crypto_current_price = @search_crypto["current_price"]
        @crypto_value = crypto.number * @crypto_current_price
        @portfolio_value += @crypto_value
      end

      wallet.cryptos.sort_by(&:name).each do |crypto|
        @search_crypto = @search_cryptos.find { |search_crypto| search_crypto["name"] == crypto.name }
        @crypto_current_price = @search_crypto["current_price"]
        @crypto_change_24h = @search_crypto["price_change_percentage_24h"]
        @crypto_symbol = @search_crypto["symbol"]

        @value = crypto.number * @crypto_current_price
        @value_change_24h = (@value * @crypto_change_24h) / 100
        @portfolio_value_change_24h += @value_change_24h

        @portfolio_rows << {
          name: crypto.name,
          current_price: @crypto_current_price,
          allocation: (@value * 100) / @portfolio_value,
          wallet_name: wallet.name,
          number: crypto.number,
          value: @value,
          symbol: @crypto_symbol
        }
      end
    end
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
