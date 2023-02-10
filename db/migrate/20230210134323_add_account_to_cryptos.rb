class AddAccountToCryptos < ActiveRecord::Migration[7.0]
  def change
    add_column :cryptos, :account, :string
  end
end
