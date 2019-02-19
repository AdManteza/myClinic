class PatientSession < ApplicationRecord
  belongs_to :site
  has_one :appointment
  has_one :patient, through: :appointment, source: :user

  delegate :time_zone, to: :site

  scope :not_in_the_past, -> do
    where('start_datetime >= ?', Time.zone.now.beginning_of_day)
  end

  scope :available, -> do
    left_joins(:appointment).where(appointments: { patient_session_id: nil } )
  end

  scope :for_date, -> (date) do
    return if date.nil?

    where('start_datetime BETWEEN ? AND ?', date.to_date.beginning_of_day, date.to_date.end_of_day)
  end

  def booked?
    patient.present?
  end
end
