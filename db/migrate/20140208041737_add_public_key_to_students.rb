class AddPublicKeyToStudents < ActiveRecord::Migration
  def change
    add_column :students, :public_key, :string, after: :ic
    add_index  :students, :public_key, unique: true
  end
end
