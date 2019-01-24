class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= begin
      if session[:user_id]
        User.find(session[:user_id])
      else
        nil
      end
    end
  end
end
