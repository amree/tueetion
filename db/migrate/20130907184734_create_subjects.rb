class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.references :center, index: true
      t.string :name
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
