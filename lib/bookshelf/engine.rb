module Bookshelf
  class Engine < Rails::Engine
    isolate_namespace Bookshelf

    # Pre-compile assets under rails 3.1
    # @see: http://thomas.vondeyen.com/2011/11/09/precompile-assets-from-rails-3-1-engines/
    if Rails.version >= '3.1'
      initializer :assets do |config|
        Rails.application.config.assets.precompile += %w( news_items.css projects.css.sass news_items.css.sass scaffolds.css.scss )
      end
    end

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      g.template_engine :haml
      g.stylesheet_engine :sass
      g.view_specs false
      g.helper_specs false
    end

    initializer 'activesupport.dependencies.autoload_paths', :before => :set_autoload_paths do |app|
      ActiveSupport::Dependencies.autoload_paths << "#{root.join('lib', 'autoload')}"
    end

    initializer 'activesupport.dependencies.autoload_paths', :after => :set_autoload_paths do |app|
      require "#{root.join('lib', 'boolean')}"
    end

    initializer 'application_helper' do |app|
      ActionView::Base.send(:include, ::ApplicationHelper)
    end

    initializer 'bookshelf.routes_helper' do |app|
      ActionView::Base.send(:include, Bookshelf::RoutesHelper)
    end

    initializer 'conditional_html_tag_helper' do |app|
      ActionView::Base.send(:include, ConditionalHtmlTagHelper)
    end

  end
end
