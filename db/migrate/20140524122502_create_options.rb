class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :center, index: true
      t.string :time_zone

      t.timestamps
    end
  end
end
