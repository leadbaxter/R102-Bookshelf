$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bookshelf/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bookshelf"
  s.version     = Bookshelf::VERSION
  s.authors     = ["Brian Jackson"]
  s.email       = %w(brianj@leadbaxter.com)
  s.homepage    = "http://r102estimator.com"
  s.summary     = "Manage R102 Estimator projects."
  s.description = "Mountable Rails engine used to manage project files for the R102 Estimator web server."

  s.files = Dir["{app,config,db,lib}/**/*"] + %w(MIT-LICENSE Rakefile README.rdoc)
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  # s.add_dependency "jquery-rails"
  s.add_dependency 'haml-rails', '>= 0.3.4'

  s.add_development_dependency 'sass-rails',   '~> 3.1.5'
  s.add_development_dependency "sqlite3"
end
