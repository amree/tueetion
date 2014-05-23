class AddReceiverUserIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :user_id, :integer, after: :id
    add_index  :payments, :user_id
  end
end
