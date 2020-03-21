# frozen_string_literal: true

require_relative('lib/lox/version')

Gem::Specification.new do |spec|
  spec.name          = 'lox'
  spec.version       = Lox::VERSION
  spec.authors       = ['Richard E. Dodson']
  spec.email         = ['richard.elias.dodson@gmail.com']

  spec.summary       = 'An implementation of the Lox Language that is ' \
                       'written in Ruby.'
  spec.homepage      = 'https://github.com/rdodson41/ruby-lox'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rdodson41/ruby-lox'
  spec.metadata['changelog_uri'] = 'https://github.com/rdodson41/ruby-lox/issues'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions    = []

  spec.add_dependency('thor')
end
