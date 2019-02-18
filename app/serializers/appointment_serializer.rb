class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :patient_session_id, :date_and_time

  def date_and_time
    return unless appointment.patient_session_id.present?

    "#{patient_session.date} #{patient_session.start_time} to #{patient_session.end_time}"
  end

private

  def appointment
    @object
  end

  def patient_session
    PatientSessionSerializer.new(@object.patient_session)
  end
end
