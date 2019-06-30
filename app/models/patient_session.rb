class PatientSession < ApplicationRecord
  belongs_to :site
  has_one :appointment
  has_one :patient, through: :appointment, source: :user

  delegate :time_zone, to: :site

  validate :same_day_for_start_and_end_datetime, :start_time_before_end_time

  scope :not_in_the_past, lambda {
    where('start_datetime >= ?', Time.zone.now.beginning_of_day)
  }
  scope :available, lambda {
    left_joins(:appointment).where(appointments: { patient_session_id: nil })
  }
  scope :for_date, lambda { |date|
    return if date.nil?

    where('start_datetime BETWEEN ? AND ?', date.to_date.beginning_of_day, date.to_date.end_of_day)
  }

  def booked?
    patient.present?
  end

  def start_time
    start_datetime.strftime("%I:%M %p")
  end

  def end_time
    end_datetime.strftime("%I:%M %p")
  end

  def date
    start_datetime.to_date
  end

  def duration_in_minutes
    ((end_datetime - start_datetime) / 1.minutes).round
  end

  def same_day_for_start_and_end_datetime
    errors.add(:end_datetime, 'Start Time and End Time should be on the same day') if start_datetime.to_date != end_datetime.to_date
  end

  def start_time_before_end_time
    errors.add(:end_datetime, 'Start Time should be before End Time') if start_datetime > end_datetime
  end
end
