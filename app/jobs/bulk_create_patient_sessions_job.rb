class BulkCreatePatientSessionsJob < ApplicationJob
  def perform(options)
    PatientSessionCreator.call(options)
  end
end
