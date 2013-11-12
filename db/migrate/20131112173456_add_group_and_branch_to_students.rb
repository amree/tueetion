class AddGroupAndBranchToStudents < ActiveRecord::Migration
  def change
    add_column :students, :branch_id, :integer, after: :center_id
    add_column :students, :group_id, :integer, after: :branch_id

    add_index :students, :branch_id
    add_index :students, :group_id
  end
end
