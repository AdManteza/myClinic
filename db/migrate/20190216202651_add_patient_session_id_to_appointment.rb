class AddPatientSessionIdToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :patient_session, foreign_key: true
  end
end
