class AddNameToQuantityFees < ActiveRecord::Migration
  def change
    add_column :quantity_fees, :name, :string, after: :subject_id
  end
end
