class CreateOpenJobs < ActiveRecord::Migration
  def change
    create_table :open_jobs do |t|
      t.integer :company_id
      t.string :name
      t.text :description
      t.date :expires

      t.timestamps null: false
    end
  end
end
