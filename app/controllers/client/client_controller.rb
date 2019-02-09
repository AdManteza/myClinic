class Client::ClientController < ApplicationController
  before_action :current_user

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
end
