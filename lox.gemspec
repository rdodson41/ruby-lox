lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lox/version'

Gem::Specification.new do |spec|
  spec.name          = 'lox'
  spec.version       = Lox::VERSION
  spec.authors       = ['Richard E. Dodson']
  spec.email         = ['richard.elias.dodson@gmail.com']

  spec.summary       = 'An implementation of the Lox Language ' \
    'which is written in Ruby.'
  spec.homepage      = 'https://github.com/rdodson41/ruby-lox'
  spec.license       = 'MIT'

  spec.files         =
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'

  spec.required_ruby_version = '~> 2.2'
end
