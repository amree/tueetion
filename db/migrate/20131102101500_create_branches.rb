class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.references :center, index: true
      t.string :name

      t.timestamps
    end
  end
end
