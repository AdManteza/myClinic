class Admin::AdminController < ApplicationController
  before_action :current_user, :ensure_admin_only

private

  def ensure_admin_only
    return if current_user.is_a?(AdminUser)

    flash[:error] = ["Unauthorized!"]

    redirect_to root_url
  end

  def current_user
    @current_user ||= begin
      if session[:admin_user_id]
        AdminUser.find(session[:admin_user_id])
      else
        nil
      end
    end
  end
end
