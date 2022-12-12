class PagesController < ApplicationController
  def home
    require 'net/http'
    require 'json'

    @url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @coins =  JSON.parse(@response)
  end
end
