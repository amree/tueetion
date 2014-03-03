class AddPolymorphismToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :transactable_id, :int, after: :id
    add_column :transactions, :transactable_type, :string, after: :transactable_id
  end
end
