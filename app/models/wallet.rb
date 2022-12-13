class Wallet < ApplicationRecord
  belongs_to :user
  has_many :cryptos, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :category, presence: true

end
