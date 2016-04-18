class AddChannelToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :channel, :string
  end
end
