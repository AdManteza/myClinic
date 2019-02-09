class Admin::AdminController < ApplicationController
  before_action :current_user, :ensure_admin_only

  def dashboard
    render 'admin/dashboard'
  end

private

  def ensure_admin_only
    return if current_user.is_a?(AdminUser)

    redirect_to root_url, alert: 'Unauthorized! You need to login first as a site administrator'
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
