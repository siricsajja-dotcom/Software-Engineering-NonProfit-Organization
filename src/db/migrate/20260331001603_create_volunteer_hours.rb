class CreateVolunteerHours < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_hours do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :event_date
      t.float :hours

      t.timestamps
    end
  end
end