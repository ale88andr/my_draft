class Category < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :articles

  validates :name, presence:{:message => " - Это поле должно быть заполненно"}, length:{:maximum => 255, :too_long => " - Слишком длинное название, придумайте что-нибудь покороче"}

  default_scope order("name ASC")

end