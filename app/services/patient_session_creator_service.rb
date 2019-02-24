class PatientSessionCreator
  def self.call(options)

  end

private

  def start_date
    options.fetch(:start_date)
  end

  def end_date
    options.fetch(:end_date)
  end

  def starting_time
    options.fetch(:starting_time)
  end

  def duration
    options.fetch(:duration)
  end

  def interval
    options.fetch(:interval)
  end

  def per_day
    options.fetch(:per_day)
  end
end
