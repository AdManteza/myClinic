class Admin::SessionsController < SessionsController
  before_action :admin_user

  def create
    respond_to do |format|
      format.json do
        if admin_user && admin_user.authenticate(admin_session_params[:password])
          session[:admin_user_id] = admin_user.id

          render json: { location: admin_users_path, username: admin_user.username }
        else
          render json: { status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    session[:admin_user_id] = nil

    redirect_to root_url, notice: "Logged out!"
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
