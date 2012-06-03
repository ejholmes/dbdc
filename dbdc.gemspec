# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dbdc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Eric J. Holmes"]
  gem.email         = ["eric@ejholmes.net"]
  gem.description   = %q{A Ruby gem for the Force.com REST API}
  gem.summary       = %q{A Ruby gem for the Force.com REST API}
  gem.homepage      = "https://github.com/ejholmes/dbdc"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dbdc"
  gem.require_paths = ["lib"]
  gem.version       = Dbdc::VERSION

  gem.add_dependency "faraday"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "vcr"
end
