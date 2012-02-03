module Bookshelf
  class Engine < Rails::Engine
    isolate_namespace Bookshelf

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      g.template_engine :haml
      g.stylesheet_engine :sass
      g.view_specs false
      g.helper_specs false
    end
  end
end