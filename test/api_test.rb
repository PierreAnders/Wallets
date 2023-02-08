require 'test_helper'

class ApiTest < Minitest::Test
  def test_get_price
    VCR.use_cassette("get_price") do
      response = CoinGecko::Client.new.get_price("bitcoin")
      assert_equal 200, response.code
      # additional assertions
    end
  end
end
