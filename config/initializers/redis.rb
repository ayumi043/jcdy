# redis_url = ENV["REDISCLOUD_URL"] || "redis://127.0.0.1:6379/0/jcdy"
redis_url = ENV["REDISCLOUD_URL"] || "redis://127.0.0.1"
uri = URI.parse(redis_url)
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

# Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379)