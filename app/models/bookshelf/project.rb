module Bookshelf
  class Project < ActiveRecord::Base
    has_many :project_contents, :dependent => :destroy

    def contents
      project_contents
    end
  end
end
