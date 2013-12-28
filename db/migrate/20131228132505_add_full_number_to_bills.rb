class AddFullNumberToBills < ActiveRecord::Migration
  def change
    add_column :bills, :full_number, :string, after: :student_id
  end
end
