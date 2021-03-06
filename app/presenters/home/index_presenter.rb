class Home::IndexPresenter

  extend ActiveSupport::Memoizable

  def last_articles(item_limit = 3)
    Article.published.limit(item_limit)
  end

  def tooday_articles(item_limit = 5)
    Article.tooday.limit(item_limit)
  end

  def top_articles_from_month
    Article.top_views.where("created_at >= ?", 1.month.ago)
  end

  def last_comments(item_limit = 3)
  	Comment.last.limit(item_limit)
  end

  def last_books(item_limit = 3)
    Book.last.limit(item_limit)
  end

  memoize :last_articles, :top_articles_from_month

end