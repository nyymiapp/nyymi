class AddSendernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :sendername, :string
  end
end
