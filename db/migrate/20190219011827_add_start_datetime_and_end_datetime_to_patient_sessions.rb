class AddStartDatetimeAndEndDatetimeToPatientSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :patient_sessions, :start_datetime, :datetime
    add_column :patient_sessions, :end_datetime, :datetime
  end
end
