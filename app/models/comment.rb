class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :article

  delegate :username, to: :user, allow_nil: true, :prefix => :author
  
  attr_accessible :body

  validates :body, presence:{message:" - Это поле должно быть заполненно"}, length:{maximum: 1000, too_long: "Слишком большой комментарий, излагайте свои мысли, пожалуйсто, покороче!"}

  scope :last, order("created_at DESC")

  def Comment.create_comment_by_user(author, comment, to_article_id)
    comment = author.comments.new(comment)
    comment.article_id = to_article_id
    if comment.save
      "Ваш комментарий добавлен к статье"
    else
      "Возникли ошибки при добавлении комментария"
    end
  end

end