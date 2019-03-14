class BulkCreatePatientSessionsJob < ApplicationJob
  def perform(options)
    PatientSessionCreatorService.new(options).call
  end
end
