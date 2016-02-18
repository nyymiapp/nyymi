class AddFreetextToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :freetext, :text
  end
end
