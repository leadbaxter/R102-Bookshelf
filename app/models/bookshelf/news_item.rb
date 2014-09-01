module Bookshelf
  class NewsItem < ActiveRecord::Base
    default_scope { order 'publish_at DESC' }
  
    # If you're using a named scope that includes a changing variable you need to wrap it in a lambda
    # This avoids the query being cached thus becoming unaffected by changes (i.e. Time.now is constant)
    scope :not_expired, -> {
      news_items = Arel::Table.new(NewsItem.table_name)
      where(news_items[:expire_at].eq(nil).or(news_items[:expire_at].gt(Time.now)))
    }
    scope :published, -> {
      not_expired { where('publish_at < ?', Time.now) }
    }
    scope :latest, -> (*l_params) {
      published.limit( l_params.first || 10)
    }
  
    # rejects any page that has not been translated to the current locale.
    scope :translated, -> {
      pages = Arel::Table.new(NewsItem.table_name)
      translations = Arel::Table.new(NewsItem.translations_table_name)
  
      includes(:translations).where(
        translations[:locale].eq(Globalize.locale)).where(pages[:id].eq(translations[:news_item_id]))
    }
  
    def not_published? # has the published date not yet arrived?
      publish_at > Time.now
    end
  
  end
end
