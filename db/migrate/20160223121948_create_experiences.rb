class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :application_id
      t.string :place
      t.string :description
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
