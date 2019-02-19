class PatientSessionSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time

  def date
    patient_session.
      start_datetime.
      in_time_zone(patient_session.time_zone).
      to_date.
      to_formatted_s(:long)
  end

  def start_time
    patient_session.
      start_datetime.
      in_time_zone(patient_session.time_zone).
      strftime("%I:%M %p")
  end

  def end_time
    patient_session.
      end_datetime.
      in_time_zone(patient_session.time_zone).
      strftime("%I:%M %p")
  end

private

  def patient_session
    @object
  end
end
