class AddProjectKeyAndProjectTypeToBookshelfProjects < ActiveRecord::Migration
  def change
    add_column :bookshelf_projects, :project_key, :string, :null => false # generated/encoded
    add_column :bookshelf_projects, :project_type, :string, :null => false
  end
  add_index :bookshelf_projects, :project_key
end
