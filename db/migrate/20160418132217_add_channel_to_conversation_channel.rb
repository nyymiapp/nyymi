class AddChannelToConversationChannel < ActiveRecord::Migration
  def change
    add_column :conversation_channels, :channel, :string
  end
end
