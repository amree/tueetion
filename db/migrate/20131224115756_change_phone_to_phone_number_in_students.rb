class ChangePhoneToPhoneNumberInStudents < ActiveRecord::Migration
  def change
    rename_column :students, :phone, :phone_number
  end
end
