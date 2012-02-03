class CreateBookshelfNewsItems < ActiveRecord::Migration
  def change
    create_table :bookshelf_news_items do |t|
      t.string :subject
      t.text :content
      t.datetime :publish_at

      t.timestamps
    end
  end
end
