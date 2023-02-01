class Crypto < ApplicationRecord
  belongs_to :wallet

  validates :name, presence: true
  validates :number, presence: true
  validates :number, numericality: { greater_than_or_equal_to: 0 }

  require 'net/http'
  require 'json'
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

  @cryptos_option = []
  @search_cryptos.each do |search_crypto|
  @cryptos_option.push(search_crypto["name"])
  end

  SELECT_CRYPTO = @cryptos_option.sort
end
