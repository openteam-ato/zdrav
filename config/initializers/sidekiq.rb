Sidekiq::Extensions.enable_delay!

Sidekiq.configure_server do |config|
  config.redis = { password: Settings['redis.password'] }
end

Sidekiq.configure_client do |config|
  config.redis = { password: Settings['redis.password'] }
end
