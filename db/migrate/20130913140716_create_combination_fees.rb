class CreateCombinationFees < ActiveRecord::Migration
  def change
    create_table :combination_fees do |t|
      t.references :center, index: true
      t.string :name
      t.integer :min_subjects
      t.integer :max_subjects
      t.decimal :price, precision: 6, scale: 2
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
