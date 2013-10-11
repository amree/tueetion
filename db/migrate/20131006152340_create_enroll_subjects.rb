class CreateEnrollSubjects < ActiveRecord::Migration
  def change
    create_table :enroll_subjects do |t|
      t.references :enroll, index: true
      t.references :subject, index: true

      t.timestamps
    end
  end
end
