class ApplicationJob < ActiveJob::Base
  include SuckerPunch::Job
  workers 4
  max_jobs 10
end
