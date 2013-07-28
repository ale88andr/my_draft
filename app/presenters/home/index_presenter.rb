class Home::IndexPresenter

  def last_articles(item_limit = 3)
    Article.published.limit(item_limit)
  end

  def tooday_articles(item_limit = 5)
    Article.tooday.limit(item_limit)
  end

  def top_articles_from_month
    Article.top_views.where("created_at >= ?", 1.month.ago)
  end


end