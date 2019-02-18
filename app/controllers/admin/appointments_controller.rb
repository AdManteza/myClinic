class Admin::AppointmentsController < Admin::AdminController
  before_action :appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = current_site.appointments
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  def create
    @appointment = current_site.appointments.build(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html do; end
        format.json { render json: @appointment }
      else
        format.html do; end
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def appointment
    @appointment ||= current_site.appointments.where(id: params[:id]).first
  end

  def appointment_params
    params.fetch(:appointment).permit(
      :patient_session_id,
      :user_id
    )
  end
end
