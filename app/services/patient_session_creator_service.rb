class PatientSessionCreatorService
  def initialize(options)
    @options = ActiveSupport::HashWithIndifferentAccess.new(options)
  end

  attr_reader :options

  class UnknownError < StandardError; end

  def call
    ActiveRecord::Base.transaction do
      (start_date..end_date).each do |date|
        start_datetime = initial_start_datetime(date)

        next if skip_if_its_weekend?(date)

        per_day.times do |_idx|
          end_datetime = start_datetime + duration

          PatientSession.create!(site_id: site.id, start_datetime: start_datetime, end_datetime: end_datetime)

          start_datetime = end_datetime + interval # next start_datetime
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

  def skip_if_its_weekend?(date)
    (date.saturday? || date.sunday?) && skip_weekends?
  end

  def skip_weekends?
    options.fetch(:skip_weekends)
  end

  def initial_start_datetime(date)
    DateTime.new(
      date.year,
      date.month,
      date.day,
      starting_time.hour,
      starting_time.min
    ).in_time_zone(site.time_zone)
  end
end
