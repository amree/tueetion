class AddPhoneCodeToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :phone_code, :string, after: :sid
  end
end
