class AddCompanynameToOpenJob < ActiveRecord::Migration
  def change
    add_column :open_jobs, :companyname, :string
  end
end
