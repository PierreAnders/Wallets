class AddPriceToCryptos < ActiveRecord::Migration[7.0]
  def change
    add_column :cryptos, :price, :decimal
  end
end
