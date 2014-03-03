class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :reference_number
      t.string :merchant
      t.decimal :value
      t.datetime :paid_at

      t.timestamps
    end
  end
end
