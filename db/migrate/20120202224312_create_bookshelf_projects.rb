class CreateBookshelfProjects < ActiveRecord::Migration
  def change
    create_table :bookshelf_projects do |t|
      t.string :project_name
      t.string :project_number
      t.string :mod_date
      t.string :created_by
      t.boolean :archived

      t.timestamps
    end

    add_index :bookshelf_projects, :project_number
  end
end
