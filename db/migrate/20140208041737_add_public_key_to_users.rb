class AddPublicKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_key, :string, after: :access_level
    add_index  :users, :public_key, unique: true
  end
end
