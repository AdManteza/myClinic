class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :set_current_site

private

  def current_user
    @current_user ||= begin
      if session[:user_id]
        User.find(session[:user_id])
      else
        nil
      end
    end
  end

  def set_current_site
    if request.host == 'localhost'
      @current_site = 'localhost'
    else
      @current_site = 'zero_dot_zero'
    end
  end

  def current_site
    @current_site
  end
end
