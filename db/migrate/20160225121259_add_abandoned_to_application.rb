class AddAbandonedToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :abandoned, :boolean
  end
end
