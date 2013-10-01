class CreateStudentSubjects < ActiveRecord::Migration
  def change
    create_table :student_subjects do |t|
      t.references :enroll, index: true
      t.references :subject, index: true
    end
  end
end
