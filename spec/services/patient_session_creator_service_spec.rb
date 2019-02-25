require 'rails_helper'

RSpec.describe PatientSessionCreatorService do
  let(:site) { create(:site) }
  let(:options) do
    {
      site_id:       site.id,
      start_date:    '2019-01-01',
      end_date:      '2019-01-02',
      starting_time: '08:00',
      duration:      '60',
      interval:      '30',
      per_day:       '2'
    }
  end

  subject { described_class.new(options) }

  it 'creates the required number of patient sessions' do
    subject.call

    expect(site.patient_sessions.for_date(options[:start_date]).count).to eq options[:per_day].to_i
    expect(site.patient_sessions.for_date(options[:end_date]).count).to eq options[:per_day].to_i
  end

  it 'creates patient sessions with the correct attributes' do
    subject.call

    start_times = site.patient_sessions.map { |ps| ps.start_time.strftime("%I:%M") }.uniq
    end_times   = site.patient_sessions.map { |ps| ps.end_time.strftime("%I:%M") }.uniq
    dates       = site.patient_sessions.map(&:date).uniq
    durations   = site.patient_sessions.map(&:duration_in_minutes).uniq
    expected_end_times   = ['09:00', '10:30']
    expected_start_times = ['08:00', '09:30']
    expected_durations   = [options[:duration].to_i]

    expect(start_times).to match_array(expected_start_times)
    expect(end_times).to match_array(expected_end_times)
    expect(dates).to match_array([options[:start_date].to_date, options[:end_date].to_date])
    expect(durations).to match_array(expected_durations)
  end
end
