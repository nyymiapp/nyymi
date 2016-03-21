class AddInvitationsendedToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :invitationsended, :string
  end
end
