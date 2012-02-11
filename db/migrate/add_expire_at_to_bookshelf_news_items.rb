class AddExpireAtToBookshelfNewsItems < ActiveRecord::Migration
  def change
    add_column :bookshelf_news_items, :expire_at, :datetime
  end
end
