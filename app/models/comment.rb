class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :article
  attr_accessible :body

  validates :body, presence:{message:" - Это поле должно быть заполненно"}

end