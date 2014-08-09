Bugsnag.configure do |config|
  config.api_key = Rails.application.secrets.bugsnag_api
  config.use_ssl = true
  config.notify_release_stages = ["production"]
end
