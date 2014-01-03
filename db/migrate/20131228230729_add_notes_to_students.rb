class AddNotesToStudents < ActiveRecord::Migration
  def change
    add_column :students, :note3, :string, after: :school_name
    add_column :students, :note2, :string, after: :school_name
    add_column :students, :note1, :string, after: :school_name
  end
end
