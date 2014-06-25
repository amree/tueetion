class AddPriceToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :price, :decimal, precision: 6, scale: 4, after: :failed_messages
  end
end
