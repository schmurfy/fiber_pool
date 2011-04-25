class FiberPool
  def self.require_lib(path)
    require File.expand_path("../#{path}", __FILE__)
  end
  
  require_lib("fiber_pool/version")
  require_lib("fiber_pool/pool")
end
