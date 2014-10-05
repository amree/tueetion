class DropUniqueKeyForNameInCenters < ActiveRecord::Migration
  def up
    remove_index :centers, :name
  end

  def down
    add_index :centers, :name, unique: true
  end
end
