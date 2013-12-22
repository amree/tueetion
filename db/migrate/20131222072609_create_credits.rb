class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.references :center, index: true
      t.integer :amount, default: 0
      t.integer :used, default: 0
      t.decimal :cost, precision: 5, scale: 2
      t.string :transaction_number
      t.string :payment_method
      t.datetime :paid_at

      t.timestamps
    end
  end
end
