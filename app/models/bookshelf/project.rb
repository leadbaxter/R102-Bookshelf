module Bookshelf
  class Project < ActiveRecord::Base
    has_many :project_contents, :dependent => :destroy

    def as_json(options = {})
      super.tap do |answer|
        answer[:mod_date] = mod_date.to_i
      end
    end

    def contents
      project_contents
    end
  end
end
