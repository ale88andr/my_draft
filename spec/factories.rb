FactoryGirl.define do
	factory :user do
		username 				'user'
		password 				11111111
    	password_confirmation 	11111111
    	email 					'user@mail.com'
	end

	factory :role do
		name	'admin'
		id		1
	end

end