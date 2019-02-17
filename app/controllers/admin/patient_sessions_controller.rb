class Admin::PatientSessionsController < Admin::AdminController
  def index
    @patient_sessions = current_site.patient_sessions

    respond_to do |format|
      format.html do; end
      format.json { render json: @patient_sessions }
    end
  end

  def create
    @patient_session = current_site.patient_session.build(
      date:       patient_session_params[:date],
      start_time: patient_session_params[:start_time],
      start_time: patient_session_params[:end_time]
    )

    respond_to do |format|
      format.json do
        if bulk_create?
          # BulkPatientSessionCreator.generate(patient_session_params)
        else
          @patient_session.save!
        end
      end
    end
  rescue ActiveRecord::Invalid
    render json: @patient_session.errors, status: :unprocessable_entity
  end

private

  def get_patient_sessions
    patient_sessions = current_site.patient_sessions
    patient_sessions = patient_sessions.available if available_only?
    patient_sessions = patient_sessions.where(date: search_dates) if search_dates

    patient_sessions
  end

  def available_only?
    patient_session_params.fetch(:available_only, false)
  end

  def search_dates
    patient_session_params.fetch(:search_dates, false)
  end

  def bulk_create?
    patient_session_params[:per_day].to_i > 1
  end

  def patient_session_params
    params.fetch(:patient_session).permit(
      :date,
      :start_time,
      :end_time,
      :start_date,
      :end_date,
      :starting_time,
      :duration,
      :interval,
      :per_day,
      :available_only,
      :search_dates
    )
  end
end
