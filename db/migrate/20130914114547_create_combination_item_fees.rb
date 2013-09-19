class CreateCombinationItemFees < ActiveRecord::Migration
  def change
    create_table :combination_item_fees do |t|
      t.references :combination_fee, index: true
      t.references :subject, index: true

      t.timestamps
    end
  end
end
