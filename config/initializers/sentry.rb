Raven.configure do |config|
  # config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.dsn = 'https://6fa37922d4824c3d8379de9c99987c99:5fed23bb7dd1485397178e0b5317e486@sentry.io/111251'
  config.environments = %w(development production)
end