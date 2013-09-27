class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.references :student, index: true
      t.references :enrollable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
