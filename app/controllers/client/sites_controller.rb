class Client < Client::ClientController
  module SitesController
    def show
      @homepage = current_site.homepage
    end
  end
end
