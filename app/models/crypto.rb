class Crypto < ApplicationRecord
  belongs_to :wallet

  validates :name, presence: true
  validates :number, presence: true
end
