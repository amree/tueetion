class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :student, index: true
      t.string :phone_number
      t.string :content
      t.string :status

      t.timestamps
    end
  end
end
