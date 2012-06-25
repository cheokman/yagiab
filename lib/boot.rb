require "rubygems"
require "bundler/setup"
require "resque"
require "reindexer"
require "dependency_fetcher"
require "gem_async"
require "resque/server"
require "redis_directory"
require "geminabox"

Resque::redis = Redis::Directory.new(:host => (ENV["REDIS_HOST"] || "localhost")).get("resque", "gems")

Resque.after_fork do
  Resque.redis.client.reconnect
end
