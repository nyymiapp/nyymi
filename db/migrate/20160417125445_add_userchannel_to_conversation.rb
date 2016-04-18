class AddUserchannelToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :userchannel, :string
  end
end
