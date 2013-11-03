class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :center, index: true
      t.string :email
      t.string :key
      t.boolean :is_used, default: false

      t.timestamps
    end

    add_index :invitations, :key, unique: true
  end
end
