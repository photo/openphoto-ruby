# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "openphoto-ruby/version"

Gem::Specification.new do |s|
  s.name        = "openphoto-ruby"
  s.version     = Openphoto::Ruby::VERSION
  s.authors     = ["Brian Levine"]
  s.email       = ["beans@beanserver.net"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "openphoto-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.6"
  s.add_dependency "oauth", "~> 0.4.5"
  s.add_dependency "json"

end
