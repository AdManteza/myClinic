class ApplicationController < ActionController::Base
  before_action :current_site

  class NoSiteFound < StandardError
  end

private

  def current_site
    # ToDo. build a SiteFinder service to
    # handle these stuff
    @current_site ||= begin
      domain = request.host
      site = SiteFinder.get_the_site_by(domain)

      raise NoSiteFound if site.nil?

      site
    end

  rescue NoSiteFound
    # To Do. A better error handling here..
    nil
  end
end
