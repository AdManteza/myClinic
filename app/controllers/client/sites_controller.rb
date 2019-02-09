class Client::SitesController < Client::ClientController
  def show
    @homepage = current_site.domain.parameterize.underscore
  end
end
