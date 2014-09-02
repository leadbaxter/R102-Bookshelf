$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'bookshelf/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'bookshelf'
  s.version     = Bookshelf::VERSION
  s.authors     = ['Brian Jackson']
  s.email       = %w(brianj@leadbaxter.com)
  s.homepage    = 'http://r102estimator.com'
  s.summary     = 'Manage R-102 / Kitchen Knight II Estimator projects.'
  s.description = 'A mountable Rails engine to manage project files for the R102 Estimator and Kitchen Knight II web server.'

  s.files = Dir['{app,config,db,lib}/**/*'] + %w(MIT-LICENSE Rakefile README.rdoc)
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.1.0'
  # s.add_dependency "jquery-rails"
  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails', '~> 4.0.3'
  s.add_dependency 'cancan'

  s.add_development_dependency 'sqlite3'
end
