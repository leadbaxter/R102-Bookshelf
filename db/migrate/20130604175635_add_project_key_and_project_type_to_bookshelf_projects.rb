class AddProjectKeyAndProjectTypeToBookshelfProjects < ActiveRecord::Migration
  def change
    add_column :bookshelf_projects, :project_key, :string, :null => false, :default => 'UNKNOWN' # generated/encoded
    add_column :bookshelf_projects, :project_type, :string, :null => false, :default => 'UNKNOWN'
  end
  add_index :bookshelf_projects, :project_key
end
