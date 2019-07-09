module PatientSessionsHelper
  def edit_patient_path(patient_session)
    link_to patient_session.patient_full_name, edit_admin_user_path(patient_session.patient), target: '_blank'
  end

  def edit_appointment_path(appointment)
    link_to appointment.id, edit_admin_appointment_path(appointment), target: '_blank'
  end
end