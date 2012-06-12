class DepFetcher
  @queue = :dependency_fetcher

  def self.perform(path, gem_name)
    Geminabox::DependencyFetcher.fetch path, gem_name
  end
end
