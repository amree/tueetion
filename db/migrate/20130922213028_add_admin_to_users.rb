class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, after: :unconfirmed_email, default: false
  end
end
