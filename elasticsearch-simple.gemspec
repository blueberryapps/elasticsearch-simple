# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elasticsearch/simple/version'

Gem::Specification.new do |spec|
  spec.name          = "elasticsearch-simple"
  spec.version       = Elasticsearch::Simple::VERSION
  spec.authors       = ["Jiří Zajpt"]
  spec.email         = ["jzajpt@blueberry.cz"]
  spec.description   = %q{Simple extension of elasticsearch gem to allow easy indexing and searching}
  spec.summary       = %q{Simple extension of elasticsearch gem to allow easy indexing and searching}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_dependency 'elasticsearch'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
