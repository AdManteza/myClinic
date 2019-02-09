class Admin::SessionsController < SessionsController
  before_action :admin_user, only: [:create]

  def create
    respond_to do |format|
      format.json do
        if admin_user && admin_user.authenticate(admin_session_params[:password])
          session[:admin_user_id] = admin_user.id

          render json: { location: admin_dashboard_path, username: admin_user.username }
        else
          render status: 401, json: { message: 'unauthorized' }
        end
      end
    end
  end

  def destroy
    session[:admin_user_id] = nil
    @current_user = nil

    render json: { location: root_url }
  end

private

  def admin_user
    @admin_user ||= AdminUser.find_by_username(admin_session_params[:username])
  end

  def admin_session_params
    params.fetch(:admin_user_session).permit(
      :username,
      :password
    )
  end
end
