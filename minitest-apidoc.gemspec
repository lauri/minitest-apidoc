# encoding: utf-8
$: << File.expand_path('../lib', __FILE__)
require 'minitest/apidoc/version'

Gem::Specification.new do |gem|
  gem.name          = "minitest-apidoc"
  gem.version       = MiniTest::Apidoc::VERSION
  gem.authors       = ["Kovalo"]
  gem.email         = ["team@kovalo.com"]
  gem.description   = "Generate API documentation from MiniTest specs"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/kovalo/minitest-apidoc"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'minitest-reporters'
  gem.add_dependency 'rack-test'
  gem.add_dependency 'mustache'
end