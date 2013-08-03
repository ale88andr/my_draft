class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  attr_accessible :content, :published, :title, :category_id, :views, :tag_ids

  before_validation {title.squish.capitalize}
  before_validation {content.squish.capitalize}

  # validations
  validates :content, presence:{:message => " - Это поле должно содержать данные"}
  validates :title, length:{:maximum => 255, :too_long => " - Это поле слишком длинное, придумайте название покороче", :minimum => 1, :too_short => " - Это поле не должно быть пустым"}
  validates :category_id, presence:{:message => " - Вам необходимо выбрать категорию"}

  delegate :username, to: :user, allow_nil: true, :prefix => :author

  # scopes
  scope :last,        order("created_at DESC")
  scope :published,   last.where("published = ?", true)
  scope :unpublished, where("published = ?", false)
  scope :tooday,      lambda { where("created_at >= ?", 1.day.ago).
                      published }
  scope :week,        lambda { where("created_at >= ?", 1.week.ago).
                      published }
  scope :month,       lambda { where("created_at >= ?", 1.month.ago).
                      published }
  scope :top_views,   order("views DESC").published.limit(10)

  # class methods
  def Article.get_articles_by_pages(option=nil, current_page=nil, per_page=5)
    @articles = case option
      when 'tooday'     then self.tooday
      when 'month'      then self.month
      when 'week'       then self.week
      when 'top_views'  then self.top_views
      else self.published
    end
    @articles.page(current_page).per(per_page)
  end

end