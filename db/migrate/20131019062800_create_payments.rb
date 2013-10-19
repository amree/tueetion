class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :bill, index: true
      t.decimal :amount, precision: 5, scale: 2
      t.datetime :paid_at

      t.timestamps
    end
  end
end
