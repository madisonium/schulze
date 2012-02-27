# -*- encoding: utf-8 -*-
require File.expand_path('../lib/schulze/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bradley Grzesiak"]
  gem.email         = ["brad@bendyworks.com"]
  gem.description   = %q{The Schulze Method, for ruby}
  gem.summary       = %q{The Schulze Method is a Condorcet voting method that computes a list of candidates sorted by the electorate's preferences}
  gem.homepage      = "https://github.com/madisonium/schulze"

  gem.executables   = 'bin/schulze'
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "schulze"
  gem.require_paths = ["lib"]
  gem.version       = Schulze::VERSION

  gem.add_development_dependency 'rspec'
end
