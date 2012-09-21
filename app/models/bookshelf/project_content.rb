module Bookshelf
  class ProjectContent < ActiveRecord::Base
    belongs_to :project
  end
end
