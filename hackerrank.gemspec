# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hackerrank/version'

Gem::Specification.new do |spec|
  spec.name          = "hackerrank"
  spec.version       = Hackerrank::VERSION
  spec.authors       = ["Danny Guinther"]
  spec.email         = ["dannyguinther@gmail.com"]
  spec.summary       = %q{Libs for my HackerRank solutions}
  spec.description   = %q{Libs for my HackerRank solutions}
  spec.homepage      = "https://github.com/tdg5/hackerrank"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "ruby-graphviz", "~> 1.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "thor", "~> 0.19"
end
