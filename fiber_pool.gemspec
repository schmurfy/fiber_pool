# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fiber_pool/version"

Gem::Specification.new do |s|
  s.name        = "fiber_pool"
  s.version     = FiberPool::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Julien Ammmous"]
  s.email       = []
  s.homepage    = ""
  s.summary     = %q{Fiber Pool Implementation}
  s.description = %q{A General purpose fiber pool}

  s.rubyforge_project = "fiber_pool"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  
end
