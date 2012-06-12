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
end

Geminabox.data = "/opt/workspace/projects/tmp/gem_sync/geminaboxplus/data"
run Geminabox
#run Rack::URLMap.new("/" => Geminabox, "/resque" => Resque::Server.new)
