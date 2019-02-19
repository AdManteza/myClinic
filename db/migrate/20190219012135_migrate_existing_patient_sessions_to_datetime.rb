class MigrateExistingPatientSessionsToDatetime < ActiveRecord::Migration[5.2]
  def change
    PatientSession.find_in_batches do |batch|
      batch.each do |patient_session|
        ex_date_start_time = patient_session.date.to_s + " #{patient_session.start_time.hour}:#{patient_session.start_time.min}"
        ex_date_end_time   = patient_session.date.to_s + " #{patient_session.end_time.hour}:#{patient_session.end_time.min}"
        new_start_datetime = ex_date_start_time.in_time_zone(patient_session.site.time_zone)
        new_end_datetime   = ex_date_end_time.in_time_zone(patient_session.site.time_zone)

        patient_session.update_attributes(start_datetime: new_start_datetime, end_datetime: new_end_datetime)
      end
    end
  end
end
