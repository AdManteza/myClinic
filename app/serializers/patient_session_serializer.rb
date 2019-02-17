class PatientSessionSerializer < ActiveModel::Serializer
  attributes :date, :start_time, :end_time

  def date
    patient_session.date.to_formatted_s(:long)
  end

  def start_time
    patient_session.start_time.strftime("%I:%M %p")
  end

  def end_time
    patient_session.end_time.strftime("%I:%M %p")
  end

private

  def patient_session
    @object
  end
end
