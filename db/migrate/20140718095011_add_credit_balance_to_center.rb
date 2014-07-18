class AddCreditBalanceToCenter < ActiveRecord::Migration
  def change
    add_column :centers, :credit_balance, :decimal, precision: 8, scale: 4, default: 0, after: :name
  end
end
