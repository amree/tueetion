class CreateBillItems < ActiveRecord::Migration
  def change
    create_table :bill_items do |t|
      t.references :bill, index: true
      t.string :name
      t.decimal :amount, precision: 5, scale: 2

      t.timestamps
    end
  end
end
