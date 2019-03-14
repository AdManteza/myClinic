class BulkCreatePatientSessionsJob < ApplicationJob
  def perform(options)
    ActiveRecord::Base.connection_pool.with_connection do
      PatientSessionCreatorService.new(options).call
    end
  end
end
