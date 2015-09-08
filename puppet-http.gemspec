# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet/http/version'

Gem::Specification.new do |spec|
  spec.name          = "puppet-http"
  spec.version       = Puppet::Http::VERSION
  spec.authors       = ["DeathKing"]
  spec.email         = ["deathking0622@gmail.com"]

  spec.summary       = %q{Enable Puppet master/agent communicate via HTTP.}
  spec.description   = %q{Enable Puppet master/agent communicate via HTTP.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  # We have to carefully deal with puppet dependency, because it seems that Gem couldn't recognize
  # Puppet installed via install.rb script which will cause a gem install then. For now, we just assume
  # user have already installed Puppet.   -- DeathKing 2015-09-06

  # spec.add_runtime_dependency "puppet"
end
