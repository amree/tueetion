class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :center, index: true
      t.references :student, index: true
      t.integer :number
      t.integer :month
      t.integer :year
      t.decimal :total_amount, precision: 5, scale: 2
      t.boolean :is_overdue, default: false
      t.boolean :is_paid, default: false
      t.datetime :overdue_at

      t.timestamps
    end
  end
end
