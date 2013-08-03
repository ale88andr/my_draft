FactoryGirl.define do

  factory :user do
    username                'user'
    password                'Pa$$w0rd'
    password_confirmation 	'Pa$$w0rd'
    email                   'user@mail.com'
	end

  factory :role do
    name  'admin'
    id    1
  end

  factory :tag do
    name                'Test tag'
  end

  factory :category do
    name                'Test category'
    description         'Test category description'
  end

  factory :article do
    sequence(:title)      {|i| "Post #{i}"}
    sequence(:content)    {|i| "Content of post #{i}"}
    published             true
    views                 1
    user_id               1
    association :category
  end

end