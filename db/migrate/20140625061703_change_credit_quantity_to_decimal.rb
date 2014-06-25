class ChangeCreditQuantityToDecimal < ActiveRecord::Migration
  def up
    change_column :credits, :amount, :decimal, precision: 8, scale: 4
    change_column :credits, :used,   :decimal, precision: 8, scale: 4
  end

  def down
    change_column :credits, :amount, :integer
    change_column :credits, :used,   :integer
  end
end
