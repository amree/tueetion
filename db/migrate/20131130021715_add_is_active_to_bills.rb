class AddIsActiveToBills < ActiveRecord::Migration
  def change
    add_column :bills, :is_active, :boolean, after: :overdue_at, default: true
  end
end
