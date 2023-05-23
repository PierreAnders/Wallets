class PagesController < ApplicationController
  require 'net/http'
  require 'json'

  def home
    @coins = CoinGeckoService.new.get_coins_markets
    @select_cryptos = @coins.map { |coin| coin["name"] }.sort
  end

  def portfolio
    @search_cryptos = CoinGeckoService.new.get_coins_markets

    @wallets = Wallet.where(user: current_user)

    @portfolio_value = 0
    @number_of_crypto = 0
    @portfolio_value_change_24h = 0
    @portfolio_rows = []

    @wallets.each do |wallet|
      @number_of_crypto += wallet.cryptos.size
      wallet.cryptos.sort_by(&:name).each do |crypto|
        @search_crypto = @search_cryptos.find { |search_crypto| search_crypto["name"] == crypto.name }
        @crypto_current_price = @search_crypto["current_price"]
        @crypto_value = crypto.number.to_f * @crypto_current_price.to_f
        @portfolio_value += @crypto_value
      end

      wallet.cryptos.sort_by(&:name).each do |crypto|
        @search_crypto = @search_cryptos.find { |search_crypto| search_crypto["name"] == crypto.name }
        @crypto_value = crypto.number.to_f * @crypto_current_price.to_f
        @crypto_change_24h = @search_crypto["price_change_percentage_24h"]
        @crypto_symbol = @search_crypto["symbol"]
        @crypto_logo = @search_crypto["image"]

        @value = crypto.number * @crypto_current_price
        @value_change_24h = (@value * @crypto_change_24h) / 100
        @portfolio_value_change_24h += @value_change_24h

        @portfolio_rows << {
          account: crypto.account,
          name: crypto.name,
          current_price: @crypto_current_price,
          allocation: (@value * 100) / @portfolio_value,
          wallet_name: wallet.name,
          number: crypto.number,
          value: @value,
          symbol: @crypto_symbol,
          image: @crypto_logo
        }
      end
    end
    @portfolio_rows.sort_by! { |row| -row[:value] }
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

  def fetch_coingecko_data
    Rails.cache.fetch('coingecko_data', expires_in: 10.minutes) do
      url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=50&page=1'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  rescue => e
    Rails.logger.error "Failed to fetch data from Coingecko: #{e.message}"
    []
  end  
end
