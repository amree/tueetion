class CreateCreditUsages < ActiveRecord::Migration
  def change
    create_table :credit_usages do |t|
      t.references :message, index: true
      t.references :credit, index: true

      t.timestamps
    end
  end
end
