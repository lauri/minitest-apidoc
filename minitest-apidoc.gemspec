$: << File.expand_path("../lib", __FILE__)
require "minitest/apidoc/version"

Gem::Specification.new do |gem|
  gem.name          = "minitest-apidoc"
  gem.version       = Minitest::Apidoc::VERSION
  gem.email         = ["git@lap.fi"]
  gem.authors       = gem.email
  gem.description   = "Generate API documentation from Minitest specs"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/lauri/minitest-apidoc"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "minitest",  ">= 5.11.2"
  gem.add_dependency "rack-test", "~> 0.6.0"
  gem.add_dependency "mustache", "~> 1.0.0"
end
