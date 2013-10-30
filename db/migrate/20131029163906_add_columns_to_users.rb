class AddColumnsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string, after: :email
    add_column :users, :last_name, :string, after: :first_name
    add_column :users, :access_level, :integer, after: :last_name, default: 50

    remove_column :users, :unconfirmed_email
    remove_column :users, :is_admin
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :access_level

    add_column :users, :unconfirmed_email, :string, after: :last_sign_in_ip
    add_column :users, :is_admin, :boolean, after: :unconfirmed_email
  end
end
