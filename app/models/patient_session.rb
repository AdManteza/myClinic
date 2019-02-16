class PatientSession < ApplicationRecord
  belongs_to :site
  has_one :appointment
  has_one :patient, through: :appointment, source: :user

  scope :available, -> do
    left_joins(:appointment).where(appointments: { patient_session_id: nil } )
  end

  def booked?
    patient.present?
  end
end
