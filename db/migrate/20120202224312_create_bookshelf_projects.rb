class CreateBookshelfProjects < ActiveRecord::Migration
  def change
    create_table :bookshelf_projects do |t|
      t.string :name
      t.string :created_by
      t.string :content_id
      t.boolean :archived

      t.timestamps
    end
  end
end
