class ReverseAssociationInCenterAndUser < ActiveRecord::Migration
  def up
    remove_column :centers, :user_id

    add_column :users, :center_id, :integer, after: :id, default: nil
    add_index :users, :center_id
  end

  def down
    add_column :centers, :user_id, :integer, after: :id, default: nil
    add_index  :centers, :user_id

    remove_column :users, :center_id
  end
end
