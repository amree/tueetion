class CreateSettingsCredits < ActiveRecord::Migration
  def change
    create_table :settings_credits do |t|
      t.references :center, index: true
      t.integer :count
      t.decimal :amount
      t.string :transaction_number
      t.string :payment_method
      t.datetime :paid_at

      t.timestamps
    end
  end
end
