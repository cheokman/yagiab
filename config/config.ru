$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "../lib")))
require "boot"

class Geminabox
  private
  def reindex(force_rebuild = false)
    Geminabox.fixup_bundler_rubygems!
    force_rebuild = true unless settings.incremental_updates
    Resque.enqueue(Reindexer, settings.data, force_rebuild)
  end
  
  def install_dependencies(path, gem_name)
    Resque.enqueue(DepFetcher, path, gem_name)
  end

  def sync_gems(path, hosts)
    hosts.each do |host|
      Resque.enqueue(GemAsync, path, host)
    end
  end
end

# Config default Geminabox gem path
# Geminabox.data = "/var/yagiab/data"
#

#
# Config master role of this service, default is false
# Geminabox.master = true
#

#
# Config sync host list
# Geminabox.sync_hosts = ["http://localhost:3001"]
#
run Geminabox
#run Rack::URLMap.new("/" => Geminabox, "/resque" => Resque::Server.new)
