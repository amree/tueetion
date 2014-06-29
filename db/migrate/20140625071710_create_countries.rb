class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :calling_code
      t.decimal :sms_rate, precision: 6, scale: 4
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
