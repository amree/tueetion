class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :center
      t.string :ic
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :email
      t.string :phone
      t.string :school_name

      t.timestamps
    end
  end
end
