class CreateQuantityFees < ActiveRecord::Migration
  def change
    create_table :quantity_fees do |t|
      t.references :center, index: true
      t.references :subject, index: true
      t.decimal :price, precision: 6, scale: 2
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
