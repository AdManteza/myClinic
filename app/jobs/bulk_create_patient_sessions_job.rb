class BulkCreatePatientSessionsJob < ApplicationJob
  def perform(options)
    PatientSessionCreator.generate(options)
  end
end
