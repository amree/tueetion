class AddProcessedContentToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :processed_content, :string, after: :content
  end
end
