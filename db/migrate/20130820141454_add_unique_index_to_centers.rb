class AddUniqueIndexToCenters < ActiveRecord::Migration
  def change
    add_index :centers, :name, unique: true
  end
end
