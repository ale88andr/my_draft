class Article < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_and_belongs_to_many :tags

  attr_accessible :content, :published, :title, :category_id, :views, :tag_ids

  # validations
  validates :content, presence:{:message => " - Это поле должно содержать данные"}
  validates :title, length:{:maximum => 255, :too_long => " - Это поле слишком длинное, придумайте название покороче", :minimum => 1, :too_short => " - Это поле не должно быть пустым"}
  validates :category_id, presence:{:message => " - Вам необходимо выбрать категорию"}

  # scopes
  scope :last,        order("created_at DESC")
  scope :published,   last.where("published = ?", true)
  scope :unpublished, where("published = ?", false)
  scope :tooday,      published.where("created_at >= ?", 1.day.ago)
  scope :week,        published.where("created_at >= ?", 1.week.ago)
  scope :month,       published.where("created_at >= ?", 1.month.ago)
  scope :top_views,   order("views DESC").published.limit(10)

end