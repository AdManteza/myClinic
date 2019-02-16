class Admin::PatientSessionsController < Admin::AdminController
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
      :per_day
    )
  end
end
