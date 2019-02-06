class Client::SitesController < Client::ClientController
  def show
    @homepage  = current_site.domain.parameterize.underscore
    @site_name = current_site.name
  end
end
