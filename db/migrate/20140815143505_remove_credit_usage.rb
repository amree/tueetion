class RemoveCreditUsage < ActiveRecord::Migration
  def up
    drop_table :credit_usages
  end

  def down
    create_table :credit_usages do |t|
      t.references :message, index: true
      t.references :credit, index: true

      t.timestamps
    end
  end
end
