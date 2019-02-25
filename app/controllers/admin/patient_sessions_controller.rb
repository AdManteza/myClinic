class Admin::PatientSessionsController < Admin::AdminController
  before_action :patient_sessions, only: [:index]

  def index
    respond_to do |format|
      format.html do; end
      format.json { render json: @patient_sessions }
    end
  end

  def create
    options = patient_session_params.merge(site_id: current_site.id)

    respond_to do |format|
      format.json do
        if bulk_create?
          BulkCreatePatientSessionsJob.perform_async(options)
        else
          PatientSessionCreatorService.new(options).call
        end
      end
    end
  rescue PatientSessionCreatorService::UnknownError, ActiveRecord::RecordInvalid => boom
    render json: boom.message, status: :unprocessable_entity
  end

private

  def patient_sessions
    @patient_sessions ||= begin
      scope = current_site.patient_sessions.includes(:appointment, :patient)
      scope = scope.available.not_in_the_past if available_only?
      scope = scope.for_date(search_date) if search_date

      scope
    end
  end

  def available_only?
    params.fetch(:available_only, false)
  end

  def search_date
    params.fetch(:search_date, false)
  end

  def bulk_create?
    patient_session_params[:per_day].to_i > 1
  end

  def patient_session_params
    params.fetch(:patient_session).permit(
      :start_date,
      :end_date,
      :starting_time,
      :duration,
      :interval,
      :per_day
    )
  end
end
