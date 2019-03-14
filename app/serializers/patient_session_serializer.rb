class PatientSessionSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time, :patient_name, :appointment_id

  def date
    patient_session.date.strftime("%a %b-%d-%Y")
  end

  def start_time
    patient_session.start_time
  end

  def end_time
    patient_session.end_time
  end

  def patient_name
    return 'Available For Booking' if patient_session.patient.nil?

    patient_session.patient.full_name
  end

  def appointment_id
    return if patient_session.patient.nil?

    patient_session.appointment.id
  end

private

  def patient_session
    @object
  end
end
