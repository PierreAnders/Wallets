class CreateCryptos < ActiveRecord::Migration[7.0]
  def change
    create_table :cryptos do |t|
      t.string :name
      t.string :address
      t.decimal :number
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
