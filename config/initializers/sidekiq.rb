ENV['REDISCLOUD_URL'] ||= 'redis://127.0.0.1:6379'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }
end
