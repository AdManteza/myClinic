class Client::ClientController < ApplicationController
  before_action :current_user

private

  def current_user
    @current_user ||= begin
      if session[:user_id]
        User.find(session[:user_id])
      elsif session[:admin_user_id]
        # it could also be an Admin
        AdminUser.find(session[:admin_user_id])
      else
        nil
      end
    end
  end
end
