class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :center, index: true
      t.integer :quantity
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
