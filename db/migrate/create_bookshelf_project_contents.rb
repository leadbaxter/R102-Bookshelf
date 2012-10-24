class CreateBookshelfProjectContents < ActiveRecord::Migration
  def change
    create_table :bookshelf_project_contents do |t|
      t.references :project
      t.string :created_by  # user email
      t.text :body
      t.text :comments

      t.timestamps
    end
    add_index :bookshelf_project_contents, :project_id
    add_index :bookshelf_project_contents, :created_by
  end
end
