class AddUserIdToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :user_id, :integer, after: :id
    add_index  :centers, :user_id
  end
end
