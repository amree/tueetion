class RemoveMinMaxFromCombinationFees < ActiveRecord::Migration
  def up
    remove_column :combination_fees, :min_subjects
    remove_column :combination_fees, :max_subjects
  end

  def down
    add_column :combination_fees, :min_subjects, :integer, after: :name
    add_column :combination_fees, :max_subjects, :integer, after: :min_subjects
  end
end
