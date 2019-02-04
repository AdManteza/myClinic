class SitesController < ApplicationController
  def index
    if request.host == 'localhost'
      redirect_to :show
    end
  end

  def show
    binding.pry
  end
end
