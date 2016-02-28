class AddStrictplaceToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :strictplace, :string
  end
end
