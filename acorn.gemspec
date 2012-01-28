# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acorn/version"

Gem::Specification.new do |s|
  s.name        = "acorn"
  s.version     = Acorn::VERSION
  s.authors     = ["me"]
  s.email       = ["me@stuffihavemade.com"]
  s.homepage    = ""
  s.summary     = %q{A DSL for seed.rb}
  s.description = %q{A DSL for seed.rb}

  s.rubyforge_project = "acorn"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ruby-debug19'
  s.add_development_dependency 'rake'
  s.add_runtime_dependency 'activerecord'
  s.add_runtime_dependency 'json'
end
