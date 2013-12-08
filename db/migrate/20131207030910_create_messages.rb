class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :center, index: true
      t.references :student, index: true
      t.string :sid
      t.string :phone_number
      t.string :content
      t.string :sent_content
      t.string :failed_messages
      t.string :status

      t.timestamps
    end
  end
end
