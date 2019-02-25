class PatientSessionCreatorService
  def initialize(options)
    @options = ActiveSupport::HashWithIndifferentAccess.new(options)
  end

  attr_reader :options

  class UnknownError < StandardError
  end

  def call
    Time.use_zone(site.time_zone) do
      PatientSession.transaction do
        (start_date..end_date).each do |date|
          start_datetime = set_initial_start_datetime(date)

          per_day.times do |idx|
            end_datetime = start_datetime + duration

            PatientSession.create(site_id: site.id, start_datetime: start_datetime, end_datetime: end_datetime)

            start_datetime = end_datetime + interval # next start_datetime
          end
        end
      end
    end
  rescue
    raise UnknownError
  end

private

  def site
    Site.find(options.fetch(:site_id))
  end

  def start_date
    options.fetch(:start_date).to_date
  end

  def end_date
    options.fetch(:end_date).to_date
  end

  def starting_time
    Time.parse(options.fetch(:starting_time))
  end

  def duration
    options.fetch(:duration).to_i.minutes
  end

  def interval
    options.fetch(:interval).to_i.minutes
  end

  def per_day
    options.fetch(:per_day).to_i
  end

  def set_initial_start_datetime(date)
    DateTime.new(
      date.year,
      date.month,
      date.day,
      starting_time.hour,
      starting_time.min
    )
  end
end
