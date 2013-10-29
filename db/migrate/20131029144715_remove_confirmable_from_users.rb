class RemoveConfirmableFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
  end

  def down
    add_column :users, :confirmation_token, :string, after: :last_sign_in_ip
    add_column :users, :confirmed_at, :datetime, after: :confirmation_token
    add_column :users, :confirmation_sent_at, :datetime, after: :confirmed_at

    add_index :users, :confirmation_token, :unique => true
  end
end
