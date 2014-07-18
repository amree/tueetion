class RemoveUsedFromCredits < ActiveRecord::Migration
  def up
    remove_column :credits, :used
  end

  def down
    add_column :credits, :used, :decimal, precision: 8, scale: 4, default: 0, after: :amount
  end
end
