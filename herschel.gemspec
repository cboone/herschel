# -*- encoding: utf-8 -*-
require File.join([File.dirname(__FILE__), 'lib', 'herschel', 'version.rb'])

Gem::Specification.new do |gem|
  gem.name = 'herschel'
  gem.version = Herschel::VERSION
  gem.author = 'Christopher Boone'
  gem.email = 'chris@hypsometry.com'
  gem.homepage = 'https://github.com/cboone/herschel'

  gem.description = ''
  gem.summary = ''

  gem.require_paths << %w(lib)
  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^spec/})

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'pry-nav'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_runtime_dependency 'gli', '>= 2.5.0'
  gem.add_runtime_dependency 'methadone', '>= 1.2.2'

  gem.platform = Gem::Platform::RUBY
end
