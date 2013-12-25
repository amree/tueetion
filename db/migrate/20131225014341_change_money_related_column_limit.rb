class ChangeMoneyRelatedColumnLimit < ActiveRecord::Migration
  def up
    change_column :bill_items, :amount, :decimal, precision: 7, scale: 2
    change_column :bills, :total_amount, :decimal, precision: 7, scale: 2
    change_column :combination_fees, :price, :decimal, precision: 7, scale: 2
    change_column :credits, :cost, :decimal, precision: 7, scale: 2
    change_column :payments, :amount, :decimal, precision: 7, scale: 2
    change_column :quantity_fees, :price, :decimal, precision: 7, scale: 2
  end

  def down
    change_column :bill_items, :amount, :decimal, precision: 7, scale: 2
    change_column :bills, :total_amount, :decimal, precision: 7, scale: 2
    change_column :combination_fees, :price, :decimal, precision: 7, scale: 2
    change_column :credits, :cost, :decimal, precision: 7, scale: 2
    change_column :payments, :amount, :decimal, precision: 7, scale: 2
    change_column :quantity_fees, :price, :decimal, precision: 7, scale: 2
  end
end
