require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyClinic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Use SuckerPunch for Background Jobs
    config.active_job.queue_adapter = :sucker_punch

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.force_ssl = true unless Rails.env == 'development'

    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => false,
        :view_specs => true,
        :helper_specs => true,
        :routing_specs => true,
        :controller_specs => true,
        :request_specs => true
    end
  end
end
