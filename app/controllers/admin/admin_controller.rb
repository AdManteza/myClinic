class Admin::AdminController < ApplicationController
  before_action :current_user, :ensure_admin_only

private

  def ensure_admin_only
    return if current_user.is_a?(AdminUser)

    redirect_to root_url, notice: "Unauthorized!"
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
