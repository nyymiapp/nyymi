class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :open_job_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
