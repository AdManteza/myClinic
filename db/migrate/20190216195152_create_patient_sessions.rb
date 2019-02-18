class CreatePatientSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_sessions do |t|
      t.belongs_to :site
      t.date :date
      t.time :start_time
      t.time :end_time
    end
  end
end
