class Admin::SessionsController < SessionsController
  def create
    admin_user = AdminUser.find_by_username(params[:username])

    if admin_user && admin_user.authenticate(params[:password])
      session[:admin_user_id] = admin_user.id

      redirect_to user_path(id: admin_user.id), notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"

      render "new"
    end
  end

  def destroy
    session[:admin_user_id] = nil

    redirect_to root_url, notice: "Logged out!"
  end
end
