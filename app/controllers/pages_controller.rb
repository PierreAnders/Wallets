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

  # def nfts
  # require 'uri'
  # require 'net/http'

  # url = URI("https://rest.cryptoapis.io/wallet-as-a-service/wallets/60c9d9921c38030006675ff6/bitcoin/testnet?context=yourExampleString")

  # http = Net::HTTP.new(url.host, url.port)

  # request = Net::HTTP::Get.new(url)
  # request["Content-Type"] = 'application/json'
  # request["X-API-Key"] = 'my-api-key'

  # response = http.request(request)
  # puts response.read_body
  # end

end
