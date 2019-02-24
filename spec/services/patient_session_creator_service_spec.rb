require 'rails_helper'

RSpec.describe PatientSessionCreatorService do
  let(:site) { create(:site) }
  let(:options) do
    {
      start_date: '',
      end_date: '',
      starting_time: '',
      duration: '',
      interval: '',
      per_day: ''
    }
  end

  subject { described_class.call(options) }

  it 'should be ok' do
    subject
  end
end
