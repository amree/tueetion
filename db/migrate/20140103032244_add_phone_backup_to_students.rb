class AddPhoneBackupToStudents < ActiveRecord::Migration
  def change
    add_column :students, :backup_phone_code, :string, after: :phone_number
    add_column :students, :backup_phone_number, :string, after: :backup_phone_code
  end
end
