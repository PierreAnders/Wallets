class RenameTypeToCategoryInWallets < ActiveRecord::Migration[7.0]
  def change
    rename_column :wallets, :type, :category
  end
end
