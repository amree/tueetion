class AddPhoneCodeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :phone_code, :string, after: :email
  end
end
