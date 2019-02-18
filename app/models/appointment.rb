class Appointment < ApplicationRecord
  belongs_to :site
  belongs_to :user
  belongs_to :patient_session
end
