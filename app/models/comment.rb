class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :article
  
  attr_accessible :body

  validates :body, presence:{message:" - Это поле должно быть заполненно"}, length:{maximum: 1000, too_long: "Слишком большой комментарий, излагайте свои мысли, пожалуйсто, покороче!"}

  scope :last, order("created_at DESC")

end