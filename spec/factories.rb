FactoryGirl.define do
	factory :admin do
		username 	'admin'
		password 	'admin'
    password_confirmation 'admin'
    email 'admin@mail.com'
	end
end