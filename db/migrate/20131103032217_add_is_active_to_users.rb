class AddIsActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_active, :boolean, after: :last_sign_in_ip, default: true
  end
end
