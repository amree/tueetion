class RemoveTransactionFromCredits < ActiveRecord::Migration
  def up
    remove_column :credits, :cost
    remove_column :credits, :transaction_number
    remove_column :credits, :payment_method
    remove_column :credits, :paid_at
  end

  def down
    add_column :credits, :cost, :decimal, precision: 5, scale: 2, after: :used
    add_column :credits, :transaction_number, :string, after: :cost
    add_column :credits, :payment_method, :string, after: :transaction_number
    add_column :credits, :paid_at, :datetime, after: :payment_method
  end
end
