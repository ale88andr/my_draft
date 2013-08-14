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

  factory :book do
    sequence(:title)       {|i| "Title of book #{i}"}
    author                 "author"
    sequence(:description) {|i| "Description of book #{i}"}
    year                   2010
    publisher              "publisher"
    language               "language"
    number_of_pages        180
    ISBN10                 1234567891
    ISBN13                 1234567891234
    link_to_book           "http://www.book.com/link_to_book"
    category_of_book       1
    book_img               "book_img"
  end

end