class GemAsync
  @queue = :gem_async
    
  def self.perform(path, host)
    Geminabox::GemSync.new(path,host).sync
  end
end
