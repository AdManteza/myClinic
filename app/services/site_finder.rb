class SiteFinder
  def self.get_the_site_by(domain)
    Site.find_by_domain(domain)
  end
end
