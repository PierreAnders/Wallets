class Crypto < ApplicationRecord
  belongs_to :wallet

  validates :name, presence: true
  validates :number, presence: true

  require 'net/http'
  require 'json'
  @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250'
  @uri = URI(@url)
  @response = Net::HTTP.get(@uri)
  @search_cryptos = JSON.parse(@response)

  @cryptos_option = []
  @search_cryptos.each do |search_crypto|
  @cryptos_option.push(search_crypto["name"])
  end

  SELECT_CRYPTO = @cryptos_option
end
