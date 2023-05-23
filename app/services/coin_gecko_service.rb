class CoinGeckoService
    require 'net/http'
    require 'json'
    
    BASE_URL = "https://api.coingecko.com/api/v3/"
  
    def get_coins_markets(params = {})
      Rails.cache.fetch('coingecko_data', expires_in: 2.minutes) do
        uri = URI("#{BASE_URL}coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1")
        response = Net::HTTP.get(uri)
        JSON.parse(response)
      end
    rescue => e
      Rails.logger.error "Failed to fetch data from Coingecko: #{e.message}"
      []
    end

    def get_coin_options
        coins = get_coins_markets
        coins.map { |coin| coin["name"] }.sort
      rescue => e
        Rails.logger.error "Failed to fetch coin options from CoinGecko: #{e.message}"
        []
    end

    def search_for_crypto
        get_coins_markets(vs_currency: 'eur', order: 'market_cap_desc', per_page: 250, page: 1)
    end

  end
  