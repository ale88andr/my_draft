class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :article
  attr_accessible :body, :user_id

  validates :body, presence:{message:" - Это поле должно быть заполненно"}

end