Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.log_level = :info
  config.log_tags = [:request_id]
  config.active_support.report_deprecations = false
  # Set to true once you have HTTPS configured
  config.force_ssl = false
end
