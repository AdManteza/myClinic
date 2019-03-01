class PatientSessionSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time

  def date
    patient_session.date.to_formatted_s(:long)
  end

  def start_time
    patient_session.start_time
  end

  def end_time
    patient_session.end_time
  end

private

  def patient_session
    @object
  end
end
