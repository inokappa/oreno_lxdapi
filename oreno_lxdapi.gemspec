# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oreno_lxdapi/version'

Gem::Specification.new do |spec|
  spec.name          = 'oreno_lxdapi'
  spec.version       = OrenoLxdapi::VERSION
  spec.authors       = ['inokappa']
  spec.email         = ['inokara at gmail.com']

  spec.summary       = 'LXD API Client for Ruby.'
  spec.description   = 'LXD API Client for Ruby.'
  spec.homepage      = 'https://github.com/inokappa/oreno_lxdapi'

  spec.files         = `git ls-files -z`.split("\x0").reject\
                       { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'net_http_unix'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop', '~> 0.47.0'
end
