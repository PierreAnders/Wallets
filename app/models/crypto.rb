class Crypto < ApplicationRecord
  belongs_to :wallet

  validates :name, presence: true
  validates :number, presence: true
  validates :number, numericality: { greater_than_or_equal_to: 0 }
  validates :account, presence: true

  SELECT_CRYPTO = CoinGeckoService.new.get_coin_options
end
