class Client::SitesController < Client::ClientController
  def show
    @homepage = current_site.homepage
  end
end
