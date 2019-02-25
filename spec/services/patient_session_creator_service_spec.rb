require 'rails_helper'

RSpec.describe PatientSessionCreatorService do
  let(:site) { create(:site) }
  let(:options) do
    {
      start_date: '2019-01-01',
      end_date: '2019-02-02',
      starting_time: '8:00',
      duration: '60',
      interval: '30',
      per_day: '2'
    }
  end

  subject { described_class }

  it 'creates the required number of patient sessions' do
    subject.call(options)

    expect(site.patient_sessions.for_date(options[:start_date]).count).to eq options[:per_day].to_i
    expect(site.patient_sessions.for_date(options[:end_date]).count).to eq options[:per_day].to_i
  end

  it 'creates patient sessions with the correct attributes' do
    subject.call(options)

    start_times = site.patient_sessions.map { |ps| ps.start_time.strftime("%I:%M %p") }.uniq
    end_times   = site.patient_sessions.map { |ps| ps.end_time.strftime("%I:%M %p") }.uniq
    dates       = site.patient_sessions.map(&:date).uniq
    expected_end_times = ['9:00', '10:30']
    expected_start_times = ['8:00', '9:30']

    expect(start_times).to match_array(expected_start_times)
    expect(end_times).to match_array(expected_end_times)
    expect(dates).to match_array([options[:start_date].to_date, options[:end_date].to_date])

    site.patient_sessions.each do |patient_session|
      expect(patient_session.duration_in_minutes).to eq options[:duration].to_i
    end
  end
end
