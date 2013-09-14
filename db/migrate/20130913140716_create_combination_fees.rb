class CreateCombinationFees < ActiveRecord::Migration
  def change
    create_table :combination_fees do |t|
      t.references :center, index: true
      t.string :name
      t.integer :min_subjects
      t.integer :max_subjects
      t.decimal :price, precision: 4, scale: 2
      t.boolean :is_active

      t.timestamps
    end
  end
end
