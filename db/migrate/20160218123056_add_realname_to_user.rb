class AddRealnameToUser < ActiveRecord::Migration
  def change
    add_column :users, :realname, :string
  end
end
