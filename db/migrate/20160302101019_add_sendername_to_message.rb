class AddSendernameToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sendername, :string
  end
end
