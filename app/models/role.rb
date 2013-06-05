class Role < ActiveRecord::Base

	# assosiation for user
  	has_and_belongs_to_many :users

	attr_accessible :name
	
end
